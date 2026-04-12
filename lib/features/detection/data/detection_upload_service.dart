import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:true_vision/features/detection/core/detection_media_type.dart';
import 'package:true_vision/features/auth/data/token_storage.dart';

class DetectionUploadException implements Exception {
  DetectionUploadException(this.message, {this.statusCode});
  final String message;
  final int? statusCode;

  @override
  String toString() => 'DetectionUploadException(statusCode: $statusCode, message: $message)';
}

class DetectionUploadService {
  DetectionUploadService({http.Client? client, TokenStorage? tokenStorage})
      : _client = client ?? http.Client(),
        _tokenStorage = tokenStorage;

  static const String _baseUrl = 'http://graduationapiproject.runasp.net/api/v1/upload';

  final http.Client _client;
  final TokenStorage? _tokenStorage;

  Uri get _imageUploadUri => Uri.parse('$_baseUrl/image');

  Future<Map<String, dynamic>> uploadMedia({
    required File file,
    required DetectionMediaType type,
  }) async {
    // جلب التوكن من الـ Storage
    final token = _tokenStorage?.getToken();

    if (token == null || token.isEmpty) {
      throw DetectionUploadException('Authentication token is missing. Please login again.');
    }

    final request = http.MultipartRequest('POST', _imageUploadUri);

    // إضافة الـ Authorization Header بالصيغة الصحيحة
    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    final fileExtension = file.path.split('.').last;
    String mainType = _getMainType(type);

    // إضافة الملف باستخدام الكي "File" كما في Swagger
    request.files.add(
      await http.MultipartFile.fromPath(
        'File',
        file.path,
        contentType: MediaType(mainType, fileExtension),
      ),
    );

    // إضافة الـ Path (1 للصور، 4 للفيديو، 5 للصوت)
    request.fields['Path'] = _pathFor(type);

    try {
      final streamedResponse = await _client.send(request).timeout(const Duration(minutes: 2));
      final response = await http.Response.fromStream(streamedResponse);

      return _handleJsonResponse(response);
    } on SocketException {
      throw DetectionUploadException('No Internet connection or server is down.');
    } catch (e) {
      throw DetectionUploadException('Upload failed: $e');
    }
  }

  String _getMainType(DetectionMediaType type) {
    switch (type) {
      case DetectionMediaType.image: return 'image';
      case DetectionMediaType.video: return 'video';
      case DetectionMediaType.audio: return 'audio';
    }
  }

  String _pathFor(DetectionMediaType type) {
    switch (type) {
      case DetectionMediaType.image: return '1';
      case DetectionMediaType.video: return '4';
      case DetectionMediaType.audio: return '5';
    }
  }

  Map<String, dynamic> _handleJsonResponse(http.Response response) {
    final statusCode = response.statusCode;
    Map<String, dynamic>? bodyJson;

    try {
      if (response.body.isNotEmpty) {
        bodyJson = jsonDecode(response.body) as Map<String, dynamic>;
      }
    } catch (_) {}

    if (statusCode >= 200 && statusCode < 300) {
      return bodyJson ?? <String, dynamic>{};
    }

    final message = bodyJson?['message'] ?? bodyJson?['errors']?.toString() ?? 'Server error ($statusCode)';
    throw DetectionUploadException(message.toString(), statusCode: statusCode);
  }
}