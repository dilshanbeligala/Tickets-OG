import 'package:dartz/dartz.dart';

import '../../../error/error_barrel.dart';
import '../../data/models/request/request_barrel.dart';
import '../../data/models/response/response_barrel.dart';

abstract class Repository {

  Future<bool> isDark();

  Future<bool> updateThemeMode({required bool isDark});

  Future<String?> getAccessToken();

  Future<void> saveAccessToken({required String token});

  Future<String?> getRefreshToken();

  Future<void> saveRefreshToken({required String token});

  Future<void> deleteTokens();

  Future<void> saveUserData({required Map data});

  Map? getUserData();

  Future<Either<Failure, LoginResponse>> login(LoginRequest loginRequest);

  Future<Either<Failure, GetTicketDetailsResponse>> getTicketDetails();


}

