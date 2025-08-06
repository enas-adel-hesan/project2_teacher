import 'package:teacher/data/models/category_model.dart';

abstract class CategoriesState {}

class InitialState extends CategoriesState {}

class LoadingState extends CategoriesState {}

class SuccessState extends CategoriesState {
  final List<Data> categories;
  SuccessState(this.categories);
}

class ErrorState extends CategoriesState {
  final String message;
  ErrorState(this.message);
}
