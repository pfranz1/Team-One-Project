import 'package:flutter/cupertino.dart';
import 'package:team_one_application/authentication/authController.dart';
import 'package:team_one_application/filter/filterController.dart';
import 'package:team_one_application/schedule/scheduleController.dart';
import 'services/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

class ApplicationController extends ChangeNotifier {
  ApplicationController() {
    init();
  }

  bool doneInit = false;

  AuthController? authController;
  FilterController? filterController;
  ScheduleController? scheduleController;
  // When the controller is made this should be moved into it

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
    filterController =
        FilterController(uuId: uId, onAgentSelect: onFilterSelect);
    notifyListeners();
  }

  void onLogout() {
    filterController = null;
    scheduleController = null;
    notifyListeners();
  }

  void onFilterSelect(String uId) {
    scheduleController = ScheduleController(uId: uId);
    notifyListeners();
  }

  @override
  void dispose() {
    authController?.dispose();
    scheduleController?.dispose();
    scheduleController = null;
    super.dispose();
  }
}
