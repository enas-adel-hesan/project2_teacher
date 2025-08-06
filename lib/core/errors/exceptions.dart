class CacheException implements Exception {
  final String message;
  CacheException(this.message);
}

class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}
class ServerValidationException implements Exception {

  final Map<String, List<String>> errors;

  ServerValidationException(this.errors,);
}
