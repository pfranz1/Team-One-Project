import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:team_one_application/authentication/authState.dart';
import 'login_state_enums.dart';

class AuthController extends ChangeNotifier {
  Function? onLogin;
  Function? onLogout;

  AuthState authState;

  late final StreamSubscription<User?> _userChangesStreamSubscription;

  AuthController({this.onLogin, this.onLogout}) : authState = AuthState() {
    _userChangesStreamSubscription =
        FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        authState.loginState = ApplicationLoginState.loggedIn;
        print('User ${user.displayName} signed in');
      } else {
        authState.loginState = ApplicationLoginState.loggedOut;
        print('User is signed out');
      }
      notifyListeners();
    });
  }

  void startLoginFlow() {
    authState.loginState = ApplicationLoginState.emailAddress;
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
        authState.loginState = ApplicationLoginState.password;
      } else {
        authState.loginState = ApplicationLoginState.register;
      }
      authState.email = email;
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
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void cancelRegistration() {
    authState.loginState = ApplicationLoginState.loggedOut;
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
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void signOut() async {
    FirebaseAuth.instance.signOut();
  }

  @override
  void dispose() {
    _userChangesStreamSubscription.cancel();
    super.dispose();
  }
}