import 'package:flutter/cupertino.dart';
import 'package:team_one_application/authentication/authController.dart';
import 'package:team_one_application/filter/filterController.dart';
import 'services/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  bool doneInit = false;

  AuthController? authController;
  FilterController? filterController;

  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Instatiating controller after db / auth is set up
    authController = AuthController(
        onLogin: (String uId) => onLogin(uId), onLogout: () => onLogout());

    // Notify listeners that Application state is done initalizing
    doneInit = true;
    notifyListeners();
  }

  void onLogin(String uId) {
    filterController = FilterController(uuId: uId);
    notifyListeners();
  }

  void onLogout() {
    filterController = null;
    notifyListeners();
  }

  @override
  void dispose() {
    authController?.dispose();
    super.dispose();
  }
}
