import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:fare/core/network/sharedPref_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/pages/login_screen.dart';
import '../services/router.dart';
import 'network_info.dart';

/// A lightweight, reusable HTTP client for Flutter apps with dependency injection support.
/// Works seamlessly with get_it by passing http.Client in the constructor.

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  ApiException(this.message, [this.statusCode]);

  @override
  String toString() => 'ApiException($statusCode): $message';
}

class ConnectionException implements Exception {

  ConnectionException();

  @override
  String toString() => 'ConnectionException()';
}


class ApiService {
  final http.Client client;
  final NetworkInfo networkInfo;
  final SharedPrefService  sharedPrefService;
  ApiService(this.client,this.networkInfo,this.sharedPrefService);

  /// Base URL for all requests (set this before using the service)
  String baseUrl = 'https://visitor.fidarsepahan.com/api/';

  /// Optional bearer token
  String? _token;

  /// Default timeout for requests
  Duration timeout = const Duration(seconds: 30);

  /// Set or update auth token
  void setToken(String token) => _token = token;
  void clearToken() => _token = null;

  /// Build headers for a request
  Map<String, String> _headers({Map<String, String>? extra, bool json = true}) {
    final headers = <String, String>{};
    if (json) headers['Content-Type'] = 'application/json';
    headers['Accept'] = 'application/json';
    if (_token != null && _token!.isNotEmpty) {
      headers['Authorization'] = 'Bearer $_token';
    }
    if (extra != null) headers.addAll(extra);
    return headers;
  }

  Uri _buildUri(String path, [Map<String, dynamic>? queryParams]) {
    final cleanPath = path.startsWith('http') ? path : baseUrl + path;
    if (queryParams == null || queryParams.isEmpty) return Uri.parse(cleanPath);
    return Uri.parse(cleanPath).replace(queryParameters: _stringifyMap(queryParams));
  }

  Map<String, String> _stringifyMap(Map<String, dynamic> input) {
    return input.map((k, v) => MapEntry(k, v == null ? '' : v.toString()));
  }

  Future<T> get<T>(String path,
      {Map<String, dynamic>? queryParameters,
        Map<String, String>? extraHeaders,
        T Function(dynamic data)? decode}) async {

    if (!await networkInfo.isConnected) {
      throw ConnectionException();
    }

    final uri = _buildUri(path, queryParameters);
    debugPrint('url_is: $uri');
    final response = await client
        .get(uri, headers: _headers(extra: extraHeaders))
        .timeout(timeout);
    return _processResponse<T>(response, decode);
  }

  Future<T> post<T>(String path,
      {dynamic body,
        Map<String, dynamic>? queryParameters,
        Map<String, String>? extraHeaders,
        T Function(dynamic data)? decode}) async {

    if (!await networkInfo.isConnected) {
      throw ConnectionException();
    }

    final uri = _buildUri(path, queryParameters);
    final encoded = body == null ? null : _encodeBody(body);
    final response = await client
        .post(uri, headers: _headers(extra: extraHeaders), body: encoded)
        .timeout(timeout);
    return _processResponse<T>(response, decode);
  }

  Future<T> put<T>(String path,
      {dynamic body,
        Map<String, dynamic>? queryParameters,
        Map<String, String>? extraHeaders,
        T Function(dynamic data)? decode}) async {

    if (!await networkInfo.isConnected) {
      throw ConnectionException();
    }

    final uri = _buildUri(path, queryParameters);
    final encoded = body == null ? null : _encodeBody(body);
    final response = await client
        .put(uri, headers: _headers(extra: extraHeaders), body: encoded)
        .timeout(timeout);
    return _processResponse<T>(response, decode);
  }

  Future<T> delete<T>(String path,
      {dynamic body,
        Map<String, dynamic>? queryParameters,
        Map<String, String>? extraHeaders,
        T Function(dynamic data)? decode}) async {
    if (!await networkInfo.isConnected) {
      throw ConnectionException();
    }
    final uri = _buildUri(path, queryParameters);
    final encoded = body == null ? null : _encodeBody(body);
    final response = await client
        .delete(uri, headers: _headers(extra: extraHeaders), body: encoded)
        .timeout(timeout);
    return _processResponse<T>(response, decode);
  }

  /// Upload file(s) as multipart form data
  /// files: Map<fieldName, File>
  Future<T> upload<T>(String path,
      {required Map<String, File> files,
        Map<String, String>? fields,
        Map<String, String>? extraHeaders,
        T Function(dynamic data)? decode}) async {
    if (!await networkInfo.isConnected) {
      throw ConnectionException();
    }

    final uri = _buildUri(path);
    final request = http.MultipartRequest('POST', uri);
    request.headers.addAll(_headers(extra: extraHeaders, json: false));

    // add fields
    if (fields != null) request.fields.addAll(fields);

    // add files
    for (final entry in files.entries) {
      final stream = http.ByteStream(entry.value.openRead());
      final length = await entry.value.length();
      final multipart = http.MultipartFile(entry.key, stream, length,
          filename: entry.value.path.split(Platform.pathSeparator).last);
      request.files.add(multipart);
    }

    final streamedResponse = await request.send().timeout(timeout);
    final response = await http.Response.fromStream(streamedResponse);
    return _processResponse<T>(response, decode);
  }

  String _encodeBody(dynamic body) {
    if (body is String) return body;
    try {
      return jsonEncode(body);
    } catch (_) {
      return body.toString();
    }
  }

  T _processResponse<T>(http.Response response, T Function(dynamic data)? decode)  {
    final status = response.statusCode;
    final bodyStr = response.body;

    dynamic decoded;
    if (bodyStr.isNotEmpty) {
      try {
        decoded = jsonDecode(bodyStr);
      } catch (_) {
        decoded = bodyStr;
      }
    }

    if (status >= 200 && status < 300) {

      log('result_is: $bodyStr');
      if (decode != null) return decode(decoded);
      if (T == String) return decoded is String ? decoded as T : bodyStr as T;
      return decoded as T;
    }

    if(status==401)
      {
         sharedPrefService.clear();


        router.go(LoginScreen.routeName);
      }

    String message = 'Request failed with status $status';
    if (decoded is Map && decoded['message'] != null) message = decoded['message'];
    throw ApiException(message, status);
  }

  /// Optional: dispose http client if manually created
  void dispose() {
    client.close();
  }
}

// class Result<T> {
//   final T? data;
//   final String? error;
//   final bool success;
//
//   Result.success(this.data)
//       : success = true,
//         error = null;
//
//   Result.failure(this.error)
//       : success = false,
//         data = null;
// }

/*
Usage with get_it:

1) In service_locator.dart:

   final sl = GetIt.instance;

   Future<void> initServiceLocator() async {
     sl.registerLazySingleton<http.Client>(() => http.Client());
     sl.registerLazySingleton<ApiService>(() => ApiService(sl<http.Client>()));
   }

2) In main.dart:
   await initServiceLocator();

3) Use anywhere:
   final api = sl<ApiService>();
   final data = await api.get('/users');
*/
