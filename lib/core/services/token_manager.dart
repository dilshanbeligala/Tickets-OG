import '../../features/data/datasources/data_source_barrel.dart';
import '../../features/data/models/request/request_barrel.dart';
import '../../features/data/models/response/response_barrel.dart';
import '../../error/exceptions.dart' as exe;
import 'service_barrel.dart';

class TokenManager {
  TokenManager._internal();

  static final TokenManager _instance = TokenManager._internal();

  bool _isRefreshing = false;
  bool refreshing = false;
  DateTime? refreshedAt;

  var tokenService = injection<TokenService>();
  var remoteDataSource = injection<RemoteDataSource>();

  factory TokenManager() {
    return _instance;
  }

  Future<String?> getToken() async {
    if (_isRefreshing) {
      await Future.delayed(const Duration(seconds: 1));
      return getToken();
    } else {

      String? token = await tokenService.getToken();
      return token;
    }
  }

  Future<void> refreshTokens() async {
    if (!_isRefreshing) {
      _isRefreshing = true;
      var currentDate = DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch);
      if (refreshedAt != null &&
          currentDate.difference(refreshedAt!).inMinutes < 2) {
        _isRefreshing = false;
        return;
      }
      try {
        final response = await remoteDataSource.rotateToken(RotateTokenRequest(refreshToken: await tokenService.getRefreshToken()));
        refreshedAt = DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch);
        await tokenService.setToken(accessToken: '${response?.data?.token}', refreshToken: '${response?.data?.refreshToken}');
      } catch(e){
        var tokenService = injection<TokenService>();
        await tokenService.deleteToken();
        throw exe.UnAuthorizedException(
            errorResponseModel:const ErrorResponseModel(
              errorCode: 'Unauthorized',
              errorDescription: 'Please log in before using this feature.',
            )
        );
      }finally{
        _isRefreshing = false;
      }
    } else {
      // If a refresh request is already in progress, wait for it to complete
      await Future.delayed(const Duration(seconds: 2));
      await refreshTokens();
    }
  }
}
