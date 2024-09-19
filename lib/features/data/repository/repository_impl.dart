import 'dart:async';
import 'package:class_q/error/error_barrel.dart';
import 'package:class_q/features/data/models/request/request_barrel.dart';
import 'package:class_q/features/data/models/response/response_barrel.dart';
import 'package:dartz/dartz.dart';
import '../../../core/network/network_barrel.dart';
import '../../domain/repository/repository.dart';
import '../datasources/data_source_barrel.dart';



class RepositoryImpl implements Repository {
  final RemoteDataSource? remoteDataSource;
  final NetworkInfo? networkInfo;
  final LocalDataSource? localDataSource;
  final StreamController<String?> _tokenController = StreamController<String?>.broadcast();

  RepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.localDataSource,
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
  Future<Map?> getUserData() {
    return localDataSource!.getMap(LocalStorageKey.userData);
  }

  @override
  Future<void> saveUserData({required Map data}) {
    return localDataSource!.setMap(LocalStorageKey.userData, data);
  }

  void _notifyTokenChange(String? token) {
    _tokenController.add(token);
  }

  Future<void> _setToken(String token) async {
    await localDataSource?.setSecreteString(LocalStorageKey.token, token);
    _notifyTokenChange(token);
  }

  Future<void> _deleteToken() async {
    await localDataSource?.deleteSecreteString(LocalStorageKey.token);
    _notifyTokenChange(null);
  }

  @override
  Future<bool> isSignedIn() async {
    // return FirebaseAuth.instance.currentUser != null;
    return false;
  }

  @override
  Future<Either<Failure, RegisterResponse>> register(RegisterRequest registerRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final response = await remoteDataSource?.register(registerRequest);
        return Right(response!);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, LoginResponse>> login(LoginRequest loginRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final response = await remoteDataSource?.login(loginRequest);
        return Right(response!);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, RecoverResponse>> recover(RecoverRequest recoverRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final response = await remoteDataSource?.recover(recoverRequest);
        return Right(response!);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, VerifyOtpResponse>> verifyOtp(VerifyOtpRequest verifyOtpRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final response = await remoteDataSource?.verifyOtp(verifyOtpRequest);
        return Right(response!);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, ResetResponse>> reset(ResetRequest resetRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final response = await remoteDataSource?.reset(resetRequest);
        return Right(response!);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

}
