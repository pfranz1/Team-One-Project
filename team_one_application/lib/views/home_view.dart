import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_one_application/applicationState.dart';
import 'package:team_one_application/authentication/authController.dart';
import 'package:team_one_application/authentication/authView.dart';
import 'package:team_one_application/authentication/login_state_enums.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, appState, _) {
        // Rebuilds from here if the appState ever notifies listeners
        final Widget _loginComponent;

        if (appState.authController != null &&
            appState.authController!.authState.loginState !=
                ApplicationLoginState.loggedIn) {
          _loginComponent =
              // Provide the specific controller as low as possible
              ChangeNotifierProvider<AuthController>(
            // The controller handles being the listener notifier
            create: (context) => appState.authController!,
            child: Consumer<AuthController>(
              builder: (context, authController, _) {
                // Rebuilds from here if authController notifies listeners
                return Authentication(
                  loginState: authController.authState.loginState,
                  email: authController.authState.email,
                  startLoginFlow: authController.startLoginFlow,
                  verifyEmail: authController.verifyEmail,
                  signInWithEmailAndPassword:
                      authController.signInWithEmailAndPassword,
                  cancelRegistration: authController.cancelRegistration,
                  registerAccount: authController.registerAccount,
                  signOut: authController.signOut,
                  firstText: 'Sign In / Register',
                );
              },
            ),
          );
        } else {
          _loginComponent = Container(
            child: Text('Already logged in'),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text("Home"),
            automaticallyImplyLeading: false,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [_loginComponent],
          ),
        );
      },
    );
  }
}
