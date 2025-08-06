// import 'dart:developer' as developer;
//
// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import '../exceptions.dart';
// import '../failures.dart';
// import 'dio_error_handler.dart'; // Import your Dio error handler
//
// Future<Either<Failure, T>> handleApiCall<T>(Future<T> Function() call) async {
//   try {
//     final result = await call();
//     if (result == null) {
//       return Left(ServerFailure('Null response received'));
//     }
//
//     return Right(result);
//   }
//   on DioException catch (e, stackTrace) {
//     developer.log('Dio Error: ${e.message}', stackTrace: stackTrace);
//     return Left(handleDioError(e));
//   }
//   on ServerException catch (e, stackTrace) {
//     developer.log('Server Error: ${e.message}', stackTrace: stackTrace);
//     return Left(ServerFailure(e.message));
//   }
//   on CacheException catch (e, stackTrace) {
//     developer.log('Cache Error: ${e.message}', stackTrace: stackTrace);
//     return Left(CacheFailure(e.message));
//   }
//   catch (e, stackTrace) {
//     developer.log('Unexpected Error: ${e.toString()}', stackTrace: stackTrace);
//     return Left(ServerFailure('An unexpected error occurred'));
//   }
// }