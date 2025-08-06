import 'dart:developer' as developer;
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../errors/error_handlers/api_filed_error.dart';
import '../errors/error_handlers/dio_error_handler.dart';
import '../errors/failures.dart';
import '../errors/exceptions.dart';
import '../errors/network/network_info.dart';

Future<Either<Failure, T>> handleNetworkCall<T>({
  required NetworkInfo networkInfo,
  required Future<T> Function() apiCall,
}) async {

  // if (!await networkInfo.isConnected) {
  //   return Left(NetworkFailure());
  // }

  try {
    final result = await apiCall();


    if (result == null) {
      return Left(ServerFailure('Null response received'));
    }

    return Right(result);
  }


  on DioException catch (e, stackTrace) {
    developer.log('Dio Error: ${e.message}', stackTrace: stackTrace);

    try {
      if (e.response?.statusCode == 422) {
        final errorMap = Map<String, dynamic>.from(e.response?.data['errors'] ?? {});
        final parsedErrors = errorMap.map((key, value) => MapEntry(key, List<String>.from(value)));
        throw ServerValidationException(parsedErrors);
      }
    } catch (_) {}

    return Left(handleDioError(e));
  }


  on FormatException catch (e, stackTrace) {
    developer.log('Format Error: ${e.message}', stackTrace: stackTrace);
    return Left(ServerFailure('Data parsing error'));
  }


  on ServerException catch (e, stackTrace) {
    developer.log('ServerException: ${e.message}', stackTrace: stackTrace);
    return Left(ServerFailure(e.message));
  }

  on CacheException catch (e, stackTrace) {
    developer.log('CacheException: ${e.message}', stackTrace: stackTrace);
    return Left(CacheFailure(e.message));
  }


  catch (e, stackTrace) {
    developer.log('Unexpected Error: ${e.toString()}', stackTrace: stackTrace);
    return Left(ServerFailure('Unexpected error: ${e.toString()}'));
  }
}
