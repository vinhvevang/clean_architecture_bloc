abstract class LoginEvent {}

class LoginSubmitEvent extends LoginEvent {
  final String tax;
  final String username;
  final String password;

  LoginSubmitEvent({
    required this.tax,
    required this.username,
    required this.password,
  });
}

class LogoutEvent extends LoginEvent {}
