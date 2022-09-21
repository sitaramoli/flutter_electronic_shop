abstract class CustomException implements Exception {}

class NetworkException implements CustomException {
  final String message;

  NetworkException({this.message = 'No Internet Connection'});
}

class ServerException extends CustomException {
  final String message;

  ServerException({this.message = 'Internal Server Error'});
}

class AuthException extends CustomException {
  final String message;

  AuthException({required this.message});
}

class CacheException extends CustomException {
  final String message;
  CacheException({this.message = 'No cache found'});
}
