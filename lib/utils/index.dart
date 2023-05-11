import 'dart:convert';
import 'dart:io';
import 'package:xpc_app/constants/general.dart';
import 'package:xpc_app/main.dart';
import 'package:xpc_app/routing/app_router.dart';
import 'package:xpc_app/storage/secure_storage.dart';
import 'package:dio/dio.dart';

enum HttpMethod { get, post, put, delete, patch }

enum VideoType { uploaded, embed, other }

String replaceTokens(String initialString, Map<String, String> tokensMap) {
  String returnString = initialString;
  tokensMap.forEach(
    (key, value) {
      returnString = returnString.replaceAll(key, value);
    },
  );
  return '<div>$returnString</div>';
}

class Authorized {
  final String baseUrl;
  final _storage = SecureStorage();
  final _dio = Dio();

  Authorized({this.baseUrl = API_URL}) {
    _dio.options.baseUrl = baseUrl;
  }

  Future<Response> request({
    required HttpMethod method,
    required String endpoint,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    String accessToken = await _storage.readSecData('access_token');
    String refreshToken = await _storage.readSecData('refresh_token');
    String accessExpiry = await _storage.readSecData('access_token_exp');
    String refreshExpiry = await _storage.readSecData('refresh_token_exp');
    final finalHeaders = {
      Headers.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      ...?headers
    };
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      final isAccExpired =
          DateTime.fromMillisecondsSinceEpoch(int.parse(accessExpiry))
                  .difference(DateTime.now())
                  .inSeconds <
              0;
      final isRefreshExpired =
          DateTime.fromMillisecondsSinceEpoch(int.parse(refreshExpiry))
                  .difference(DateTime.now())
                  .inSeconds <
              0;
      if (isRefreshExpired) {
        getIt<AppRouter>().push(const LoginRoute());
      }
      if (isAccExpired) {
        final noInterceptorDio = Dio();
        final newRefreshResponse = await noInterceptorDio.post(
            '${API_URL}token/refresh/',
            data: {'refresh': refreshToken});
        if (newRefreshResponse.statusCode == 200) {
          rewriteTokens(newRefreshResponse);
        } else {
          getIt<AppRouter>().push(const LoginRoute());
        }
      }
      return handler.next(options);
    }));

    switch (method) {
      case HttpMethod.get:
        return await _dio.get(endpoint,
            options: Options(headers: finalHeaders));
      case HttpMethod.post:
        return await _dio.post(endpoint,
            options: Options(headers: finalHeaders),
            data: data,
            queryParameters: queryParameters);
      case HttpMethod.put:
        return await _dio.put(endpoint,
            options: Options(headers: finalHeaders),
            data: data,
            queryParameters: queryParameters);
      case HttpMethod.delete:
        return await _dio.get(endpoint,
            options: Options(headers: finalHeaders));
      case HttpMethod.patch:
        return await _dio.patch(endpoint,
            options: Options(headers: finalHeaders),
            data: data,
            queryParameters: queryParameters);
      default:
        throw Exception('Invalid HTTP method');
    }
  }
}

void rewriteTokens(Response response) {
  final tokenData = response.data;
  final storage = SecureStorage();
  Base64Codec base64 = const Base64Codec();
  final decodedAccess = utf8
      .fuse(base64)
      .decode(base64.normalize(tokenData['access'].split('.')[1]));
  final decodedRefresh = utf8
      .fuse(base64)
      .decode(base64.normalize(tokenData['refresh'].split('.')[1]));
  final accessExpiry = jsonDecode(decodedAccess)['exp'];
  final refreshExpiry = jsonDecode(decodedRefresh)['exp'];
  storage.writeSecData('access_token', tokenData['access']);
  storage.writeSecData('refresh_token', tokenData['refresh']);
  storage.writeSecData('access_token_exp', (accessExpiry * 1000).toString());
  storage.writeSecData('refresh_token_exp', (refreshExpiry * 1000).toString());
}
