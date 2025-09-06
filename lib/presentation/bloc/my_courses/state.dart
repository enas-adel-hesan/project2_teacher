import '../../../data/models/my_courses_model.dart';

class MyCoursesState {}

class InitialState extends MyCoursesState {}

class LoadingState extends MyCoursesState {}

class SuccessState extends MyCoursesState {
  final List<Data> myCourses;

  SuccessState(this.myCourses);
}

class ErrorState extends MyCoursesState {
  final String message;

  ErrorState(this.message);
}
