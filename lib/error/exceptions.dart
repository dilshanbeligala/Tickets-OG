import '../features/data/models/response/response_barrel.dart';

class ServerException implements Exception {
  final ErrorResponseModel errorResponseModel;

  ServerException({required this.errorResponseModel});
}

class APIFailException implements Exception {
  final ErrorResponseModel errorResponseModel;

  APIFailException(this.errorResponseModel);
}

class CacheException implements Exception {}

class UnAuthorizedException implements Exception {
  final ErrorResponseModel errorResponseModel;

  UnAuthorizedException({required this.errorResponseModel});
}

class HttpException implements Exception {
  final ErrorResponseModel errorResponseModel;

  HttpException({required this.errorResponseModel});
}
