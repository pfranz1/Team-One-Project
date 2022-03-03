import 'package:team_one_application/authentication/login_state_enums.dart';

class AuthState {
  // I havent made these feilds private with getters and setters becasue i got a compiler
  // warning telling me not to.
  // DO NOT: Change the values of this state object from anywhere but the controller

  String? _email;
  ApplicationLoginStep _loginStep = ApplicationLoginStep.loggedOut;

  get email => _email;
  get loginStep => _loginStep;

  get isLoggedIn => _loginStep == ApplicationLoginStep.loggedIn;

  void setLoggedIn() {
    _loginStep = ApplicationLoginStep.loggedIn;
  }

  void setLoggedOut() {
    _loginStep = ApplicationLoginStep.loggedOut;
    _email = null;
  }

  void setEmailStep() {
    _loginStep = ApplicationLoginStep.emailAddress;
  }

  void setPasswordStep(String newEmail) {
    _loginStep = ApplicationLoginStep.password;
    _email = newEmail;
  }

  void setRegisterStep1() {
    _loginStep = ApplicationLoginStep.register;
  }

  void setRegisterStep(String newEmail) {
    _email = newEmail;
    _loginStep = ApplicationLoginStep.register;
  }
}
