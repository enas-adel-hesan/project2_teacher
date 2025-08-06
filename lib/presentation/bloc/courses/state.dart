class CoursesState {}

class InitialState extends CoursesState {}

class LoadingState extends CoursesState {}

class SuccessState extends CoursesState {
  int cId;
  SuccessState(this.cId);
}

class ErrorState extends CoursesState {
  final String message;

  ErrorState(this.message);
}
