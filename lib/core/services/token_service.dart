import 'package:flutter/cupertino.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../features/data/datasources/data_source_barrel.dart';
import '../../features/data/models/common/common_barrel.dart';
import '../../features/data/models/request/request_barrel.dart';
import '../../features/domain/repository/repository_barrel.dart';
import 'service_barrel.dart';

class TokenService {
  final Repository repository;

  TokenService({required this.repository});

  Future<void> setToken({
    required String accessToken,
    required String refreshToken,
    Map<dynamic, dynamic>? userData,
  }) async {
    await repository.saveAccessToken(token: accessToken);
    await repository.saveRefreshToken(token: refreshToken);

    // Decode the token and save user data
    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
      saveUser(User.fromJson(decodedToken));
    } catch (e) {
      // Handle decoding error if needed
    }

    // Optionally override with explicit userData if provided
    if (userData != null) {
      saveUser(User.fromJson(userData.cast<String, dynamic>()));
    }
  }

  Future<bool> checkToken() async {
    String? token;
    bool status = false;
    try {
      token = await repository.getAccessToken();
      if (token == null) {
        status = false;
      } else {
        Map<String, dynamic> json = JwtDecoder.decode(token);
        var expDate = DateTime.fromMillisecondsSinceEpoch(json['exp'] * 1000);
        var currentDate = DateTime.now();

        if (currentDate.isBefore(expDate)) {
          if (getUser() != null) {
            status = true;
          } else {
            await deleteToken();
            status = false;
          }
        } else {
          var remoteDataSource = injection<RemoteDataSource>();
          final response = await remoteDataSource.rotateToken(
            RotateTokenRequest(refreshToken: await getRefreshToken()),
          );
          await setToken(
            accessToken: '${response?.data?.token}',
            refreshToken: '${response?.data?.refreshToken}',
          );
          status = true;
        }
      }
    } catch (e) {
      await deleteToken();
      status = false;
    } finally {
      if (getUser() == null) {
        status = false;
      }
    }
    return status;
  }

  Future<String?> getToken() async {
    return await repository.getAccessToken();
  }

  Future<String?> getRefreshToken() async {
    return await repository.getRefreshToken();
  }

  Future<void> deleteToken() async {
    await repository.deleteTokens();
  }

  Future<void> saveUser(User user) async {
    await repository.saveUserData(data: user.toJson());
    debugPrint('Saved user: ${user.toJson()}');
  }


  User? getUser() {
    final userData = repository.getUserData();
    if (userData != null) {
      return User.fromJson(userData.cast<String, dynamic>());
    }
    return null;
  }
}
