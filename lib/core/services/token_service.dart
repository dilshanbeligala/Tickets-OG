
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../features/data/datasources/data_source_barrel.dart';
import '../../features/data/models/common/common_barrel.dart';
import '../../features/data/models/request/request_barrel.dart';
import '../../features/domain/repository/repository_barrel.dart';
import 'service_barrel.dart';


class TokenService{
  final Repository repository;

  TokenService({required this.repository});

  Future<void> setToken({
    required String accessToken,
    required String refreshToken,
    Map<dynamic, dynamic>? userData
  }) async {
    await repository.saveAccessToken(token: accessToken);
    await repository.saveRefreshToken(token: refreshToken);

    // if (userData != null) {
    //   await saveUser(User.fromJson(userData.cast<String, dynamic>()));
    // }
  }


  Future<bool> checkToken() async {
    String? token;
    bool status = false;
    try{
      token = await repository.getAccessToken();
      if(token == null){
        status = false;
      }else{
        Map<String, dynamic> json = JwtDecoder.decode(token);
        var expDate = DateTime.fromMillisecondsSinceEpoch(json['exp'] * 1000);
        var currentDate = DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch);
        if(currentDate.isBefore(expDate)){
          if(getUser() != null) {
            status = true;
          }else{
            await deleteToken();
            status = false;
          }
        }else{
          var remoteDataSource = injection<RemoteDataSource>();
          final response = await remoteDataSource.rotateToken(RotateTokenRequest(refreshToken: await getRefreshToken()));
          await setToken(accessToken: '${response?.data?.token}', refreshToken: '${response?.data?.refreshToken}');
          status = true;
        }
      }
    }catch (e){
      await deleteToken();
      status = false;
    }finally{
      if(getUser() == null){
        status = false;
      }
    }
    return status;
  }

  getToken() async {
    return await repository.getAccessToken();
  }

  getRefreshToken() async {
    return await repository.getRefreshToken();
  }

  deleteToken() async {
    await repository.deleteTokens();
  }

  saveUser(User user) async {
    await repository.saveUserData(data: user.toJson());
  }

  User? getUser() {
    final userData = repository.getUserData();
    if (userData != null) {
      return User.fromJson(userData.cast<String, dynamic>());
    }
    return null;
  }
}