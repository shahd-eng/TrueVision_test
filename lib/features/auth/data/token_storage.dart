import 'package:shared_preferences/shared_preferences.dart';

/// Service responsible for storing and retrieving authentication tokens
/// and user information from local storage.
class TokenStorage {
  static const String _tokenKey = 'access_token';
  static const String _userEmailKey = 'user_email';
  static const String _userNameKey = 'user_name';

  late SharedPreferences _prefs;

  /// Initialize the token storage with SharedPreferences instance
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Save the access token and optional user information
  Future<void> saveToken({
    required String token,
    String? email,
    String? userName,
  }) async {
    await _prefs.setString(_tokenKey, token);
    if (email != null) {
      await _prefs.setString(_userEmailKey, email);
    }
    if (userName != null) {
      await _prefs.setString(_userNameKey, userName);
    }
  }

  /// Retrieve the stored access token
  String? getToken() {
    return _prefs.getString(_tokenKey);
  }

  /// Retrieve the stored user email
  String? getUserEmail() {
    return _prefs.getString(_userEmailKey);
  }

  /// Retrieve the stored user name
  String? getUserName() {
    return _prefs.getString(_userNameKey);
  }

  /// Check if a token is stored
  bool hasToken() {
    return _prefs.containsKey(_tokenKey);
  }

  /// Clear all stored authentication data (logout)
  Future<void> clearToken() async {
    await _prefs.remove(_tokenKey);
    await _prefs.remove(_userEmailKey);
    await _prefs.remove(_userNameKey);
  }
}
