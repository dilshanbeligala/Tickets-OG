
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tickets_og/core/services/service_barrel.dart';
import 'package:tickets_og/features/data/datasources/data_source_barrel.dart';
import 'package:tickets_og/features/data/models/request/request_barrel.dart';
import 'package:tickets_og/features/data/models/response/response_barrel.dart';


import '../../../core/network/api_helper.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  final APIHelper? apiHelper;
  final FlutterSecureStorage? secureStorage;
  final String baseUrl = dotenv.get('APP_BASE_URL');

  RemoteDataSourceImpl({required this.apiHelper, required this.secureStorage});

  Uri getUrl({required String url, Map<String, String>? extraParameters}) {
    final queryParameters = <String, String>{};
    if (extraParameters != null && extraParameters.isNotEmpty) {
      queryParameters.addAll(extraParameters);
      return Uri.parse('$baseUrl/$url').replace(
        queryParameters: queryParameters,
      );
    }
    return Uri.parse('$baseUrl$url');
  }

  Future<Map<String, String>> authorizedHeader() async {
    var localDataSource = injection<LocalDataSource>();
    var token =
    await localDataSource.getSecreteString(LocalStorageKey.token);
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  @override
  Future<RegisterResponse> register(
      RegisterRequest registerRequest) async {
    try {
      final response = await apiHelper!.post(
        getUrl(url: "register").toString(),
        headers: await authorizedHeader(),
        body: registerRequest.toJson(),
      );
      return RegisterResponse.fromJson(response);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<LoginResponse> login(
      LoginRequest loginRequest) async {
    try {
      final response = await apiHelper!.post(
        getUrl(url: "login").toString(),
        headers: await authorizedHeader(),
        body: loginRequest.toJson(),
      );
      return LoginResponse.fromJson(response);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<RecoverResponse> recover(
      RecoverRequest recoverRequest) async {
    try {
      final response = await apiHelper!.post(
        getUrl(url: "password/recover").toString(),
        headers: await authorizedHeader(),
        body: recoverRequest.toJson(),
      );
      return RecoverResponse.fromJson(response);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<VerifyOtpResponse> verifyOtp(
      VerifyOtpRequest verifyOtpRequest) async {
    try {
      final response = await apiHelper!.post(
        getUrl(url: "password/verify-otp").toString(),
        headers: await authorizedHeader(),
        body: verifyOtpRequest.toJson(),
      );
      return VerifyOtpResponse.fromJson(response);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<ResetResponse> reset(
      ResetRequest resetRequest) async {
    try {
      final response = await apiHelper!.post(
        getUrl(url: "password/reset").toString(),
        headers: await authorizedHeader(),
        body: resetRequest.toJson(),
      );
      return ResetResponse.fromJson(response);
    } on Exception {
      rethrow;
    }
  }
}
