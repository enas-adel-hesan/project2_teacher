import 'package:dio/dio.dart';
import '../failures.dart';

Failure handleDioError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return ServerFailure('Request timeout', 408);

    case DioExceptionType.badCertificate:
      return ServerFailure('Bad certificate', 495);

    case DioExceptionType.badResponse:
      return _handleBadResponse(error.response!);

    case DioExceptionType.cancel:
      return ServerFailure('Request cancelled', 499);

    case DioExceptionType.connectionError:
      return NetworkFailure();

    case DioExceptionType.unknown:
      if (error.message?.contains('SocketException') ?? false) {
        return NetworkFailure();
      }
      return ServerFailure('Unknown error: ${error.message}', 500);
  }
}
Failure _handleBadResponse(Response response) {
  final statusCode = response.statusCode ?? 500;

  // لو حالة 422 تعني Validation Errors (أخطاء الحقول)
  if (statusCode == 422) {
    try {
      final data = response.data;
      if (data is Map<String, dynamic> && data.containsKey('errors')) {
        final errorsMap = Map<String, dynamic>.from(data['errors']);

        // تحويل القيم لقائمة نصوص
        final fieldErrors = errorsMap.map<String, List<String>>((key, value) {
          return MapEntry(key, List<String>.from(value));
        });

final message=data['message'];
        return ValidationFailure(message, fieldErrors);
      }
    } catch (_) {
      // لو فشل التحويل تابع للرسالة العادية
    }
  }

  // رسالة عامة لو في مفتاح message
  String message = 'Server error';
  try {
    if (response.data is Map && response.data['message'] != null) {
      message = response.data['message'];
    } else {
      message = 'HTTP $statusCode';
    }
  } catch (_) {}

  return ServerFailure(message, statusCode);
}