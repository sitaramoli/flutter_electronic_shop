// ignore_for_file: annotate_overrides

abstract class Failure {
  String get message;
}

class NetworkFailure implements Failure {
  final String message;
  NetworkFailure({required this.message});
}

class ServerFailure implements Failure {
  final String message;

  ServerFailure({required this.message});
}

class HttpFailure implements Failure {
  final String message;

  HttpFailure({required this.message});
}

class AuthFailure implements Failure {
  final String message;

  AuthFailure({required this.message});
}

class OtherFailure implements Failure {
  final String message = 'There seems to be some error';

  const OtherFailure();
}
