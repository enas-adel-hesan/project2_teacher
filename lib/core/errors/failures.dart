import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../constants/strings/errors_strings.dart';

abstract class Failure {
  final String message;
  final int? code;

  Failure(this.message, [this.code]);
}

// API Failures
// In core/errors/failures.dart
class ServerFailure extends Failure {
  final int? statusCode;

  ServerFailure(super.message, [this.statusCode]);

  factory ServerFailure.fromDioError(DioException error) {
    final response = error.response;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ServerFailure(ErrorsStrings.requestTimeout, 408);

      case DioExceptionType.badResponse:
        if (response != null) {
          final message = _extractErrorMessage(response);
          return ServerFailure(message, response.statusCode);
        }
        return ServerFailure(ErrorsStrings.serverError, 500);

      case DioExceptionType.cancel:
        return ServerFailure(ErrorsStrings.requestCanceledError, 499);

      default:
        return ServerFailure(ErrorsStrings.networkError, 500);
    }
  }


  static String _extractErrorMessage(Response? response) {
    if (response == null) return ErrorsStrings.noResponseError;

    final data = response.data;


    if (data is Map<String, dynamic>) {
      for (final value in data.values) {
        if (value is List && value.isNotEmpty) {
          return value.first.toString(); // أول رسالة خطأ
        }
      }

      // إذا يوجد مفتاح "message"
      if (data['message'] != null) {
        return data['message'].toString();
      }
    }

    return '${ErrorsStrings.serverError} (${response.statusCode})';
  }


}

class CacheFailure extends Failure {
  CacheFailure(super.message);
}

class NetworkFailure extends Failure {
  NetworkFailure() : super(ErrorsStrings.networkError);
}

class ValidationFailure extends Failure {

  final Map<String, List<String>> fieldErrors;
  ValidationFailure(super.message,this.fieldErrors);
}

// Extension for easy conversion
extension FailureExtension on Failure {
  Left<Failure, T> toLeft<T>() => Left(this);
}