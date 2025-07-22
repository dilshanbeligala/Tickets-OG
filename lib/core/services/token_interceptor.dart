import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import '../../features/data/models/response/response_barrel.dart';
import 'dependency_injection.dart';
import 'token_manager.dart';
import 'token_service.dart';
import '../../error/exceptions.dart' as exe;


class TokenInterceptor extends http.BaseClient {
  final http.Client _client = http.Client();
  TokenManager tokenManager = TokenManager();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    Uint8List bodyBytes = Uint8List(0);

    if (request is http.Request) {
      bodyBytes = request.bodyBytes;
    }

    return _client.send(request).then((response) async {
      if (response.statusCode == 401) {
        var broadcastStream = response.stream.asBroadcastStream();
        var bytes = <int>[];
        await for (var chunk in broadcastStream) {
          bytes.addAll(chunk);
        }

        try{
          var res = http.Response.bytes(bytes, response.statusCode, headers: response.headers);

          Map data = jsonDecode(res.body)['data']??{};
          if(data.containsKey('code')){
            if(data['code'] == 'TOKEN_EXPIRED'){
              await tokenManager.refreshTokens();
              String newAccessToken = "${await tokenManager.getToken()}";

              final refreshedRequest = http.Request(request.method, request.url)
                ..headers.addAll(request.headers)
                ..headers['Authorization'] = 'Bearer $newAccessToken'
                ..bodyBytes = bodyBytes.toList();

              return _client.send(refreshedRequest);
            }else if(data['code'] == 'USER_SESSION_INVALID'){
              var tokenService = injection<TokenService>();
              await tokenService.deleteToken();
              throw exe.UnAuthorizedException(
                  errorResponseModel:const ErrorResponseModel(
                    errorCode: 'Unauthorized',
                    errorDescription: 'Please log in before using this feature.',
                  )
              );
            }
          }
        }catch(e){
          throw exe.ServerException(
              errorResponseModel: ErrorResponseModel(
                errorCode: 'Something Happened',
                errorDescription: e.toString(),
              )
          );
        }
        return http.StreamedResponse(Stream.fromIterable([bytes]), response.statusCode, headers: response.headers, request: response.request, reasonPhrase: response.reasonPhrase, contentLength: response.contentLength, isRedirect: response.isRedirect, persistentConnection: response.persistentConnection);
      }
      return response;
    });
  }
}

