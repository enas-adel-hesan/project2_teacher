import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:teacher/app_links.dart';
import 'package:teacher/core/errors/network/network_info.dart';
import 'package:teacher/core/network/dio_client.dart';
import 'package:teacher/core/utils/handle_network_call.dart';
import 'package:teacher/data/models/teacher_model.dart';
import 'package:teacher/presentation/bloc/register_cubit/state.dart';

import '../../../core/errors/failures.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final NetworkInfo networkInfo = GetIt.I<NetworkInfo>();

  RegisterCubit() : super(RegisterState());

  // Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final aboutYouController = TextEditingController();

  // Form keys
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();

  // Other fields
  String gender = '';
  String specialization = '';

  // Validation error messages for UI
  String emailError = '';
  String passwordError = '';
  String firstNameError = '';
  String lastNameError = '';
  String specializationError = '';
  String genderError = '';
  String aboutYouError = '';

  Map<String, dynamic> get data => {
    'email': emailController.text.trim(),
    'password': passwordController.text.trim(),
    'first_name': firstNameController.text.trim(),
    'last_name': lastNameController.text.trim(),
    'gender': gender,
    'specialization': specialization,
    'Previous_experiences': aboutYouController.text.trim(),
    'role': 'teacher',
  };

  Future<Either<Failure, TeacherModel>> register() async {
    emit(LoadingState());

    final result = await handleNetworkCall<TeacherModel>(
      networkInfo: networkInfo,
      apiCall: registerTeacher,
    );

    return result.fold(
      (failure) {
        if (failure is ValidationFailure) {
          _resetErrors();
          _setValidationErrors(failure);

          // Emit error states by steps
          if (emailError.isNotEmpty || passwordError.isNotEmpty) {
            emit(FirstStepErrorState(emailError, passwordError));
            return Left(failure);
          } else {
            emit(FirstStepSuccessState());
          }

          if (firstNameError.isNotEmpty ||
              lastNameError.isNotEmpty ||
              genderError.isNotEmpty) {
            emit(
              SecondStepErrorState(firstNameError, lastNameError, genderError),
            );
            return Left(failure);
          } else {
            emit(SecondStepSuccessState());
          }

          if (specializationError.isNotEmpty || aboutYouError.isNotEmpty) {
            emit(ThirdStepErrorState(specializationError, aboutYouError));
            return Left(failure);
          } else {
            emit(ThirdStepSuccessState());
          }

          return Left(failure);
        }

        // Generic failure
        emit(ErrorState(failure.message));
        return Left(failure);
      },
      (teacher) {
        _resetErrors();
        emit(SuccessState());
        return Right(teacher);
      },
    );
  }

  Future<TeacherModel> registerTeacher() async {
    final response = await DioHelper.postData(
      url: AppLinks.register,
      data: data,
    );
    return TeacherModel.fromJson(response.data);
  }

  void _resetErrors() {
    emailError = '';
    passwordError = '';
    firstNameError = '';
    lastNameError = '';
    specializationError = '';
    genderError = '';
    aboutYouError = '';
  }

  void _setValidationErrors(ValidationFailure failure) {
    emailError = failure.fieldErrors['email']?.first ?? '';
    passwordError = failure.fieldErrors['password']?.first ?? '';
    firstNameError = failure.fieldErrors['first_name']?.first ?? '';
    lastNameError = failure.fieldErrors['last_name']?.first ?? '';
    genderError = failure.fieldErrors['gender']?.first ?? '';
    specializationError = failure.fieldErrors['specialization']?.first ?? '';
    aboutYouError = failure.fieldErrors['Previous_experiences']?.first ?? '';
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    aboutYouController.dispose();
    return super.close();
  }

  int currentStep = 1;

  void nextStep() {
    if (currentStep < 3) {
      currentStep++;
      emit(StepChangedState(currentStep));
    }
  }
}
