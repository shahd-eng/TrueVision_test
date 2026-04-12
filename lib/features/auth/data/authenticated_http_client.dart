import 'package:http/http.dart' as http;
import 'token_storage.dart';

/// HTTP client that automatically includes the access token in requests
class AuthenticatedHttpClient extends http.BaseClient {
  AuthenticatedHttpClient({required this.tokenStorage})
    : _inner = http.Client();

  final TokenStorage tokenStorage;
  final http.Client _inner;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final token = tokenStorage.getToken();

    if (token != null && token.isNotEmpty) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    return _inner.send(request);
  }
}
