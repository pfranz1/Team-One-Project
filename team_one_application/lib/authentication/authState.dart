import 'package:team_one_application/authentication/login_state_enums.dart';

class AuthState {
  // I havent made these feilds private with getters and setters becasue i got a compiler
  // warning telling me not to.
  // DO NOT: Change the values of this state object from anywhere but the controller

  String? email;
  ApplicationLoginState loginState = ApplicationLoginState.loggedOut;

  void setLoggedIn() {
    loginState = ApplicationLoginState.loggedIn;
  }

  void setLoggedOut() {
    loginState = ApplicationLoginState.loggedOut;
    email = null;
  }

  void setEmailStep() {
    loginState = ApplicationLoginState.emailAddress;
  }

  void setPasswordStep(String newEmail) {
    loginState = ApplicationLoginState.password;
    email = newEmail;
  }

  void setRegisterStep(String newEmail) {
    email = newEmail;
    loginState = ApplicationLoginState.register;
  }
}
