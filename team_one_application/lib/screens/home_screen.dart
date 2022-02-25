import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_one_application/applicationController.dart';
import 'package:team_one_application/authentication/authController.dart';
import 'package:team_one_application/authentication/authView.dart';
import 'package:team_one_application/authentication/login_state_enums.dart';
import 'package:team_one_application/filter/filterView.dart';
import 'package:team_one_application/schedule/scheduleView.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationController>(
      // Rebuilds from here if the appState ever notifies listeners
      builder: (context, appState, _) {
        final bool _isDoneInit = appState.doneInit;
        //If i try to check for login and there is no auth controller, i am not logged in yet
        final bool _isLoggedIn =
            appState.authController?.authState.isLoggedIn ?? false;

        final bool _hasSelected =
            _isLoggedIn && appState.scheduleController != null;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Quick Share"),
            actions: [
              // Sign-Out Button
              if (_isDoneInit && _isLoggedIn)
                ElevatedButton(
                    onPressed: () => appState.authController!.signOut(),
                    child: const Text('Log Out'))
            ],
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Login Button + Login Flow
                if (!_isLoggedIn && _isDoneInit)
                  AuthView(authController: appState.authController!),
                if (_isLoggedIn && _isDoneInit)
                  FilterView(filterController: appState.filterController!),
                if (_hasSelected)
                  ScheduleView(scheduleController: appState.scheduleController!)
              ],
            ),
          ),
        );
      },
    );
  }
}
