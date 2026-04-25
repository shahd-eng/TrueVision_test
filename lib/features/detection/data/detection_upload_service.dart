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

  // الباك إند الأساسي (لرفع الملفات وحفظها في قاعدة البيانات)
  static const String _baseUrl = 'http://graduationapiproject.runasp.net/api/v1/upload';

  final http.Client _client;
  final TokenStorage? _tokenStorage;

  // ---------------------------------------------------------
  // 1. وظيفة مناداة موديل الـ AI (الصور والصوت والفيديو)
  // ---------------------------------------------------------
  Future<Map<String, dynamic>> getAiDetectionResult(File file, DetectionMediaType type) async {
    String finalUrl;
    String fileKey;

    // تحديد اللينك والـ Key بناءً على نوع الميديا
    if (type == DetectionMediaType.video) {
      // موديل الفيديو (FastAPI عبر ngrok الخاص بزميلتك)
      finalUrl = 'https://starlet-navigate-appealing.ngrok-free.dev/predict';
      fileKey = 'file';
    }
    else if (type == DetectionMediaType.image) {
      // موديل الصور (مريم نشأت)
      finalUrl = 'https://manicure-sulphuric-sputter.ngrok-free.dev/classify';
      fileKey = 'image';
    }
    else {
      // موديل الصوت (الشباب)
      finalUrl = 'https://unmarine-virgen-spiriferous.ngrok-free.dev/Predict_Audio';
      fileKey = 'audio';
    }

    var request = http.MultipartRequest('POST', Uri.parse(finalUrl));

    // --- إضافة الهيدرز لحل مشكلة ngrok وقطع الاتصال (Connection Reset) ---
    request.headers.addAll({
      'ngrok-skip-browser-warning': 'true', // تخطي صفحة التحذير اللي بتعطل الـ Request
      'Accept': 'application/json',
    });

    request.files.add(await http.MultipartFile.fromPath(fileKey, file.path));

    try {
      // رفع وقت الانتظار لـ 5 دقائق للفيديو لمواجهة البطء في الـ processing
      final timeoutDuration = type == DetectionMediaType.video
          ? const Duration(minutes: 5)
          : const Duration(minutes: 1);

      final streamedResponse = await _client.send(request).timeout(timeoutDuration);
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw DetectionUploadException(
            'AI Server Error (${_getMainType(type)})',
            statusCode: response.statusCode
        );
      }
    } catch (e) {
      // لو لسه بيدي Error هنا، يبقى السيرفر عند الطرف التاني هو اللي بيفصل
      throw DetectionUploadException('Failed to connect to AI server: $e');
    }
  }

  // ---------------------------------------------------------
  // 2. وظيفة الرفع للباك إند الأساسي (للأرشفة في الـ History)
  // ---------------------------------------------------------
  Future<Map<String, dynamic>> uploadMedia({
    required File file,
    required DetectionMediaType type,
  }) async {
    final token = _tokenStorage?.getToken();

    if (token == null || token.isEmpty) {
      throw DetectionUploadException('Authentication token is missing. Please login again.');
    }

    final request = http.MultipartRequest('POST', Uri.parse('$_baseUrl/image'));

    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    final fileExtension = file.path.split('.').last;
    String mainType = _getMainType(type);

    request.files.add(
      await http.MultipartFile.fromPath(
        'File',
        file.path,
        contentType: MediaType(mainType, fileExtension),
      ),
    );

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

  // Helper Methods
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