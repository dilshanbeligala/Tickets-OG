import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../error/exceptions.dart' as exe;
import '../../features/data/models/response/response_barrel.dart';

class APIHelper {
  final http.Client client;

  APIHelper({required this.client});

  Future<dynamic> post(String url,
      {Map<String, String>? headers,
        dynamic body,
        bool isFormData = false}) async {
    return await _sendRequest(
      url: url,
      method: 'POST',
      headers: headers,
      body: body,
    );
  }

  Future<dynamic> get(String url, {Map<String, String>? headers}) async {
    return await _sendRequest(
      url: url,
      method: 'GET',
      headers: headers,
    );
  }

  Future<dynamic> put(String url,
      {Map<String, String>? headers, dynamic body}) async {
    return await _sendRequest(
      url: url,
      method: 'PUT',
      headers: headers,
      body: body,
    );
  }

  Future<dynamic> delete(String url, {Map<String, String>? headers}) async {
    return await _sendRequest(
      url: url,
      method: 'DELETE',
      headers: headers,
    );
  }

  Future<dynamic> patch(String url,
      {Map<String, String>? headers, dynamic body, bool isFormData = false}) async {
    return await _sendRequest(
      url: url,
      method: 'PATCH',
      headers: headers,
      body: body,
    );
  }

  Future<dynamic> _sendRequest({
    required String url,
    required String method,
    Map<String, String>? headers,
    dynamic body,
  }) async {
    try {
      log('Request: $method $url\nHeaders: $headers\nBody: $body');

      http.Response response;

      switch (method) {
        case 'POST':
          response = await client.post(
            Uri.parse(url),
            headers: headers,
            body: body != null ? jsonEncode(body) : null,
          );
          break;
        case 'GET':
          response = await client.get(
            Uri.parse(url),
            headers: headers,
          );
          break;
        case 'PUT':
          response = await client.put(
            Uri.parse(url),
            headers: headers,
            body: body != null ? jsonEncode(body) : null,
          );
          break;
        case 'DELETE':
          response = await client.delete(
            Uri.parse(url),
            headers: headers,
          );
          break;
        case 'PATCH':
          response = await client.patch(
            Uri.parse(url),
            headers: headers,
            body: body != null ? jsonEncode(body) : null,
          );
          break;
        default:
          throw UnsupportedError('Unsupported HTTP method: $method');
      }

      log('Response: ${response.statusCode}\nBody: ${response.body}');
      return _handleResponse(response);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  dynamic _handleResponse(http.Response response) {
    try {
      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonResponse;
      } else {
        final errorDescription = jsonResponse['message'] ?? 'Error occurred';
        throw exe.ServerException(
          errorResponseModel: ErrorResponseModel(
            errorCode: response.statusCode.toString(),
            errorDescription: errorDescription,
          ),
        );
      }
    } catch (e) {
      throw exe.ServerException(
        errorResponseModel: ErrorResponseModel(
          errorCode: 'unknown',
          errorDescription: 'An unexpected error occurred.',
        ),
      );
    }
  }
}

