import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:team_one_application/authentication/authState.dart';
import 'package:team_one_application/services/navigation_service.dart';
import 'login_state_enums.dart';

class AuthController extends ChangeNotifier {
  Function? onLogin;
  Function? onLogout;

  AuthState authState;

  NavigationService navigationService;

  AuthController({
    this.onLogin,
    this.onLogout,
    required this.navigationService,
  }) : authState = AuthState() {
    //Check if someone is already signed in
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // We call the function here because we need to take user from state logged out to logged in
      _doOnLogin(user);
    } else {
      // We dont call the _doOnLogout function here because we have no work to do because user starts logged out
      authState.setLoggedOut();
      notifyListeners();

      print('Currently signed out');
    }
  }

  void _doOnLogin(User? user) {
    // Update Model
    authState.setLoggedIn();

    // Call lambda functions
    if (onLogin != null) onLogin!(user?.uid);
    // Change screen
    navigationService.navigateTo("/timeline");

    // ignore: avoid_print
    print('User ${user?.displayName} signed in');
    notifyListeners();
  }

  void _doOnLogout() {
    // Update Model
    authState.setLoggedOut();

    // Call lambda
    if (onLogout != null) onLogout!();

    // Change Screen
    navigationService.goBack();

    // ignore: avoid_print
    print('User has succsefully signed out');
  }

  void startLoginFlow() {
    authState.setEmailStep();
    notifyListeners();
  }

  Future<void> verifyEmail(
    String email,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      var methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.contains('password')) {
        authState.setPasswordStep(email);
      } else {
        authState.setRegisterStep(email);
      }
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) => _doOnLogin(value.user));
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void signOut() async {
    FirebaseAuth.instance.signOut().then((value) => {_doOnLogout()});
  }

  void cancelRegistration() {
    authState.setLoggedOut();
    notifyListeners();
  }

  Future<void> registerAccount(
      String email,
      String displayName,
      String password,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user!.updateDisplayName(displayName);

      final CollectionReference usersRef =
          FirebaseFirestore.instance.collection('/users');
      Map<String, dynamic> userData = {
        'displayName': displayName,
        'email': credential.user!.email,
      };
      await usersRef.doc(credential.user!.uid).set(userData);
      _doOnLogin(credential.user);
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }
}
