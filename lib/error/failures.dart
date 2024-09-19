

import 'package:equatable/equatable.dart';

import '../../features/data/models/response/response_barrel.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]);

  @override
  List<Object> get props => props;
}

class ServerFailure extends Failure {
  final ErrorResponseModel errorResponse;

  const ServerFailure(this.errorResponse);
}

class APIFailure extends Failure {
  final ErrorResponseModel errorResponse;

  const APIFailure(this.errorResponse);
}

class CacheFailure extends Failure {}

class ConnectionFailure extends Failure {}

class AuthorizedFailure extends Failure {
  final ErrorResponseModel errorResponse;

  const AuthorizedFailure(this.errorResponse);
}
