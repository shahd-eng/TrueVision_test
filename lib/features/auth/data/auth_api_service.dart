import 'dart:convert';

import 'package:http/http.dart' as http;
import 'token_storage.dart';

/// Lightweight exception used for authentication-related API errors.
class AuthException implements Exception {
  AuthException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => 'AuthException(statusCode: $statusCode, message: $message)';
}

/// Service responsible for calling the authentication endpoints.
///
/// Base URL:
///   http://graduationapiproject.runasp.net/api/v1/Authentication
class AuthApiService {
  AuthApiService({
    http.Client? client,
    TokenStorage? tokenStorage,
  })
      : _client = client ?? http.Client(),
        _tokenStorage = tokenStorage;

  static const String _baseUrl =
      'http://graduationapiproject.runasp.net/api/v1/Authentication';

  final http.Client _client;
  final TokenStorage? _tokenStorage;

  Uri _buildUri(String path) => Uri.parse('$_baseUrl/$path');

  Map<String, String> get _jsonHeaders =>
      const {
        'Content-Type': 'application/json',
      };

  /// POST /AdminLogin
  ///
  /// Body:
  /// {
  ///   "email": "string",
  ///   "password": "string"
  /// }
  Future<Map<String, dynamic>> adminLogin({
    required String email,
    required String password,
  }) async {
    final response = await _client.post(
      _buildUri('AdminLogin'),
      headers: _jsonHeaders,
      body: jsonEncode(<String, String>{
        'email': email.trim(),
        'password': password,
      }),
    );

    return _handleJsonResponse(response);
  }

  /// POST /ExternalLogin
  ///
  /// Body:
  /// {
  ///   "provider": "Google",
  ///   "token": "string"
  /// }
  ///
  /// [token] should be the ID token you receive from Google Sign-In.
  Future<Map<String, dynamic>> externalLoginWithGoogle({
    required String token,
  }) async {
    final response = await _client.post(
      _buildUri('ExternalLogin'),
      headers: _jsonHeaders,
      body: jsonEncode(<String, String>{
        'provider': 'Google',
        'token': token,
      }),
    );

    return _handleJsonResponse(response);
  }

  /// POST /ResetPassword
  ///
  /// Body:
  /// {
  ///   "email": "string",
  ///   "password": "string",
  ///   "confirmPassword": "string"
  /// }
  Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final response = await _client.post(
      _buildUri('ResetPassword'),
      headers: _jsonHeaders,
      body: jsonEncode(<String, String>{
        'email': email.trim(),
        'password': password,
        'confirmPassword': confirmPassword,
      }),
    );

    return _handleJsonResponse(response);
  }

  /// POST /Register
  ///
  /// Body:
  /// {
  ///   "email": "string",
  ///   "firstName": "string",
  ///   "lastName": "string",
  ///   "password": "string"
  /// }
  Future<Map<String, dynamic>> register({
    required String email,
    required String firstName,
    required String lastName,
    required String password,
  }) async {
    final response = await _client.post(
      _buildUri('Register'),
      headers: _jsonHeaders,
      body: jsonEncode(<String, String>{
        'email': email.trim(),
        'firstName': firstName.trim(),
        'lastName': lastName.trim(),
        'password': password,
      }),
    );

    return _handleJsonResponse(response);
  }

  /// POST /RequestOtp
  ///
  /// Body:
  /// {
  ///   "email": "string"
  /// }
  Future<Map<String, dynamic>> requestOtp({
    required String email,
  }) async {
    final response = await _client.post(
      _buildUri('RequestOtp'),
      headers: _jsonHeaders,
      body: jsonEncode(<String, String>{
        'email': email.trim(),
      }),
    );

    return _handleJsonResponse(response);
  }

  /// POST /ValidateOtp
  ///
  /// Body:
  /// {
  ///   "email": "string",
  ///   "otpCode": "string"
  /// }
  Future<Map<String, dynamic>> validateOtp({
    required String email,
    required String otpCode,
  }) async {
    final response = await _client.post(
      _buildUri('ValidateOtp'),
      headers: _jsonHeaders,
      body: jsonEncode(<String, String>{
        'email': email.trim(),
        'otpCode': otpCode,
      }),
    );

    return _handleJsonResponse(response);
  }

  Map<String, dynamic> _handleJsonResponse(http.Response response) {
    final statusCode = response.statusCode;
    Map<String, dynamic>? bodyJson;

    try {
      if (response.body.isNotEmpty) {
        bodyJson = jsonDecode(response.body) as Map<String, dynamic>;
      }
    } catch (_) {
      // If parsing fails we still throw a generic error below.
    }

    if (statusCode >= 200 && statusCode < 300) {
      // Extract and save token if present in response
      if (bodyJson != null) {
        _extractAndSaveToken(bodyJson);
      }
      return bodyJson ?? <String, dynamic>{};
    }

    final message = bodyJson?['message']?.toString() ??
        bodyJson?['error']?.toString() ??
        'Unexpected error occurred. Please try again.';

    throw AuthException(message, statusCode: statusCode);
  }

  /// Extract token from API response and save it to storage
  void _extractAndSaveToken(Map<String, dynamic> response) {
    if (_tokenStorage == null) return;

    // طباعة الاستجابة عشان نتأكد من شكل البيانات اللي راجعة من السيرفر
    print("API Response Body: $response");

    // البحث عن التوكن في كل المفاتيح المحتملة
    String? token = response['token']?.toString();
    token ??= response['accessToken']?.toString();
    token ??= response['access_token']?.toString();
    token ??= response['data']?['token']?.toString();
    token ??= response['data']?['accessToken']?.toString();

    if (token != null && token.isNotEmpty) {
      _tokenStorage!.saveToken(
        token: token,
        email: response['email']?.toString() ?? response['data']?['email']?.toString(),
        userName: response['name']?.toString() ?? response['userName']?.toString(),
      );
      print("Token Saved Successfully!");
    } else {
      print("Warning: Login success but NO token found in response keys.");
    }
  }
}
