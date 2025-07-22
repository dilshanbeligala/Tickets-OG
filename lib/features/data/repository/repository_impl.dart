import 'package:dartz/dartz.dart';
import '../../../core/network/network_barrel.dart';
import '../../../core/services/service_barrel.dart';
import '../../../error/error_barrel.dart';
import '../../domain/repository/repository.dart';
import '../datasources/data_source_barrel.dart';
import '../models/request/request_barrel.dart';
import '../models/response/response_barrel.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource? remoteDataSource;
  final NetworkInfo? networkInfo;
  final LocalDataSource? localDataSource;

  RepositoryImpl({
    required this.remoteDataSource,
    this.networkInfo,
    this.localDataSource,
  });

  @override
  Future<bool> isDark() async {
    return localDataSource!.getBool(LocalStorageKey.isDark);
  }

  @override
  Future<bool> updateThemeMode({required bool isDark}) async {
    return localDataSource!.setBool(LocalStorageKey.isDark, isDark);
  }

  @override
  Future<String?> getAccessToken() async {
    return await localDataSource!.getSecreteString(LocalStorageKey.accessToken);
  }

  @override
  Future<void> saveAccessToken({required String token}) async {
    return await localDataSource!.setSecreteString(LocalStorageKey.accessToken, token);
  }

  @override
  Future<String?> getRefreshToken() async {
    return await localDataSource!.getSecreteString(LocalStorageKey.refreshToken);
  }

  @override
  Future<void> saveRefreshToken({required String token}) async {
    return await localDataSource!.setSecreteString(LocalStorageKey.refreshToken, token);
  }

  @override
  Future<void> deleteTokens() async {
    await localDataSource!.deleteSecreteString(LocalStorageKey.accessToken);
    await localDataSource!.deleteSecreteString(LocalStorageKey.refreshToken);
    await localDataSource!.deleteMap(LocalStorageKey.userData);
    return;
  }

  @override
  Map? getUserData() {
    return localDataSource!.getMap(LocalStorageKey.userData);
  }

  @override
  Future<void> saveUserData({required Map data}) {
    return localDataSource!.setMap(LocalStorageKey.userData, data);
  }

  Future<Either<Failure, T>> _safeApiCall<T>(Future<T> Function() apiCall) async {
    if (await networkInfo!.isConnected) {
      try {
        return Right(await apiCall());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      }
    }
    return Left(ConnectionFailure());
  }

  @override
  Future<Either<Failure, LoginResponse>> login(LoginRequest request) async =>
      _safeApiCall(() async {
        final response = await remoteDataSource!.login(request);
        final tokenService = injection<TokenService>();
        await tokenService.setToken(
          accessToken: response.data?.token ?? '',
          refreshToken: response.data?.refreshToken ?? '',
          // userData: response.token?.user?.toJson() ?? {},
        );
        return response;
      });


}
