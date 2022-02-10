import 'package:flutter/cupertino.dart';
import 'package:team_one_application/authentication/authController.dart';
import 'services/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  AuthController? authController;

  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Instatiating controller after db / auth is set up
    authController = AuthController();

    // Notify listeners that Application state is done initalizing
    notifyListeners();
  }

  @override
  void dispose() {
    authController?.dispose();
    super.dispose();
  }
}
