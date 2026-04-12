import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'token_storage.dart';

/// Exception for upload operations
class UploadException implements Exception {
  UploadException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() =>
      'UploadException(statusCode: $statusCode, message: $message)';
}

/// Service for uploading files with automatic token inclusion
class FileUploadService {
  FileUploadService({http.Client? client, required TokenStorage tokenStorage})
    : _client = client ?? http.Client(),
      _tokenStorage = tokenStorage;

  static const String _baseUrl =
      'http://graduationapiproject.runasp.net/api/v1';

  final http.Client _client;
  final TokenStorage _tokenStorage;

  Uri _buildUri(String path) => Uri.parse('$_baseUrl/$path');

  /// Upload an image file
  ///
  /// [filePath] - Path to the image file to upload
  /// [fileName] - Optional custom file name (defaults to file's name)
  ///
  /// Returns the API response containing upload details
  Future<Map<String, dynamic>> uploadImage({
    required String filePath,
    String? fileName,
  }) async {
    final file = File(filePath);

    if (!await file.exists()) {
      throw UploadException('File not found: $filePath');
    }

    final token = _tokenStorage.getToken();
    if (token == null || token.isEmpty) {
      throw UploadException(
        'No authentication token found. Please login first.',
      );
    }

    final request = http.MultipartRequest('POST', _buildUri('upload/image'));

    // Add authorization header
    request.headers['Authorization'] = 'Bearer $token';

    // Add file
    request.files.add(
      http.MultipartFile.fromBytes(
        'image',
        await file.readAsBytes(),
        filename: fileName ?? file.path.split('/').last,
      ),
    );

    try {
      final streamedResponse = await _client.send(request);
      final response = await http.Response.fromStream(streamedResponse);

      return _handleUploadResponse(response);
    } on UploadException {
      rethrow;
    } catch (e) {
      throw UploadException('Upload failed: ${e.toString()}');
    }
  }

  /// Upload multiple image files
  ///
  /// Returns a list of upload responses
  Future<List<Map<String, dynamic>>> uploadImages({
    required List<String> filePaths,
  }) async {
    final results = <Map<String, dynamic>>[];

    for (final filePath in filePaths) {
      try {
        final result = await uploadImage(filePath: filePath);
        results.add(result);
      } catch (e) {
        // Continue with next file, but you might want to handle errors differently
        results.add({'error': e.toString()});
      }
    }

    return results;
  }

  /// Handle upload response
  Map<String, dynamic> _handleUploadResponse(http.Response response) {
    final statusCode = response.statusCode;
    Map<String, dynamic>? bodyJson;

    try {
      if (response.body.isNotEmpty) {
        bodyJson = _parseJsonResponse(response.body);
      }
    } catch (_) {
      // If parsing fails, throw error below
    }

    if (statusCode >= 200 && statusCode < 300) {
      return bodyJson ?? <String, dynamic>{'success': true};
    }

    final message =
        bodyJson?['message']?.toString() ??
        bodyJson?['error']?.toString() ??
        'Upload failed with status code: $statusCode';

    throw UploadException(message, statusCode: statusCode);
  }

  /// Parse JSON response (supports both Map and nested data structures)
  dynamic _parseJsonResponse(String body) {
    try {
      return jsonDecode(body);
    } catch (_) {
      return null;
    }
  }
}
