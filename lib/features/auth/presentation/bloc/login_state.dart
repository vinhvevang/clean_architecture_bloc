abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String? taxError;
  final String? usernameError;
  final String? passwordError;

  LoginFailure({this.taxError, this.usernameError, this.passwordError});
}
