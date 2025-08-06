class LoginState {}

class LoadingState extends LoginState {}

class SuccessState extends LoginState {}

class ErrorState extends LoginState {
  final String message;
  ErrorState(this.message);
}

class LoginErrorState extends LoginState {
  final String emailError;
  final String passwordError;

  LoginErrorState(this.emailError, this.passwordError);
}
