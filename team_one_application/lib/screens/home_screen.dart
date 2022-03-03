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
      builder: (context, appController, _) {
        final bool _isDoneInit = appController.doneInit;
        // If I check login and there is no auth controller, i am not logged in
        final bool _isLoggedIn =
            appController.authController?.authState.isLoggedIn ?? false;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Image.asset('images/QuickShare-logos_white.png'),
            key: const ValueKey('appBar'),
            actions: [
              // Sign-Out Button
              if (_isDoneInit && _isLoggedIn)
                ElevatedButton(
                    onPressed: () => appController.authController!.signOut(),
                    child: const Text('Log Out'))
            ],
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Login Button + Login Flow
                if (!_isLoggedIn && _isDoneInit)
                  AuthView(authController: appController.authController!),

                // Message if reached accidentaly
                if (_isLoggedIn && _isDoneInit)
                  const Text("Youve reached the home screen while logged in "),

                // Loading if appController is going slow
                if (!_isDoneInit) const CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );
  }
}
