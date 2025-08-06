import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:teacher/core/errors/failures.dart';
import 'package:teacher/core/errors/network/network_info.dart';
import 'package:teacher/core/network/dio_client.dart';
import 'package:teacher/core/utils/handle_network_call.dart';
import 'package:teacher/data/models/user_model.dart';
import 'package:teacher/presentation/bloc/login/state.dart';

import '../../../app_links.dart';
import '../../../data/services/preference_service.dart';
import '../../../injection_container.dart';

class LoginCubit extends Cubit<LoginState> {
  final NetworkInfo networkInfo = GetIt.I<NetworkInfo>();

  LoginCubit() : super(LoginState());

  // Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final preferences = sl<PreferencesService>();
  // Form Key
  final formKey = GlobalKey<FormState>();

  // Validation Errors
  String emailError = '';
  String passwordError = '';

  Map<String, dynamic> get data => {
    'email': emailController.text.trim(),
    'password': passwordController.text.trim(),
  };

  Future<Either<Failure, UserModel>> login() async {
    _resetErrors();
    emit(LoadingState());

    final result = await handleNetworkCall<UserModel>(
      networkInfo: networkInfo,
      apiCall: loginRequest,
    );

    return result.fold(
          (failure) {
        if (failure is ValidationFailure) {

          _setValidationErrors(failure);

          emit(LoginErrorState(emailError, passwordError));
          return Left(failure);
        }

        emit(ErrorState(failure.message));
        return Left(failure);
      },
          (teacher) {

        emit(SuccessState());
        preferences.saveUserData(teacher);
        return Right(teacher);
      },
    );
  }

  Future<UserModel> loginRequest() async {
    final response = await DioHelper.postData(
      url: AppLinks.login,
      data: data,
    );
    return UserModel.fromJson(response.data);
  }

  void _resetErrors() {
    emailError = '';
    passwordError = '';
  }

  void _setValidationErrors(ValidationFailure failure) {
    emailError = failure.fieldErrors['email']?.first ?? '';
    passwordError = failure.fieldErrors['password']?.first ?? '';
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
