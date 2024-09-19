

import 'package:class_q/error/error_barrel.dart';
import 'package:class_q/features/data/models/request/request_barrel.dart';
import 'package:class_q/features/data/models/response/response_barrel.dart';
import 'package:dartz/dartz.dart';


abstract class Repository {

  Future<bool> isDark();

  Future<void> saveUserData({required Map data});

  Future<Map?> getUserData();

  Future<bool> updateThemeMode({required bool isDark});

  Future<bool> isSignedIn();

  Future<Either<Failure, RegisterResponse>> register(RegisterRequest registerRequest);

  Future<Either<Failure, LoginResponse>> login(LoginRequest loginRequest);

  Future<Either<Failure, RecoverResponse>> recover(RecoverRequest recoverRequest);

  Future<Either<Failure, VerifyOtpResponse>> verifyOtp(VerifyOtpRequest verifyOtpRequest);

  Future<Either<Failure, ResetResponse>> reset(ResetRequest resetRequest);

}
