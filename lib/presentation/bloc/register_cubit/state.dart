class RegisterState {
  RegisterState init() {
    return RegisterState();
  }

  RegisterState clone() {
    return RegisterState();
  }
}

class InitialState extends RegisterState {}

class LoadingState extends RegisterState {}

class FirstStepSuccessState extends RegisterState {}

class FirstStepErrorState extends RegisterState {
  final String emailMessage;
  final String passwordMessage;

  FirstStepErrorState(this.emailMessage, this.passwordMessage);
}

class SecondStepSuccessState extends RegisterState {}

class SecondStepErrorState extends RegisterState {
  final String firstNameMessage;
  final String lastNameMessage;
  final String genderMessage;

  SecondStepErrorState(
    this.firstNameMessage,
    this.lastNameMessage,
    this.genderMessage,
  );
}

class ThirdStepSuccessState extends RegisterState {}

class ThirdStepErrorState extends RegisterState {
  final String specializationMessage;
  final String aboutYouMessage;

  ThirdStepErrorState(this.specializationMessage,this.aboutYouMessage);
}

class SuccessState extends RegisterState {}

class ErrorState extends RegisterState {
  final String message;

  ErrorState(this.message);
}
class StepChangedState extends RegisterState {
  final int step;

  StepChangedState(this.step);
}