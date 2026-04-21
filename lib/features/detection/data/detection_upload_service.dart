// شغاله صوت فقط
// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
// import 'package:true_vision/features/detection/core/detection_media_type.dart';
// import 'package:true_vision/features/auth/data/token_storage.dart';
//
// class DetectionUploadException implements Exception {
//   DetectionUploadException(this.message, {this.statusCode});
//   final String message;
//   final int? statusCode;
//
//   @override
//   String toString() => 'DetectionUploadException(statusCode: $statusCode, message: $message)';
// }
//
// class DetectionUploadService {
//   DetectionUploadService({http.Client? client, TokenStorage? tokenStorage})
//       : _client = client ?? http.Client(),
//         _tokenStorage = tokenStorage;
//
//   static const String _baseUrl = 'http://graduationapiproject.runasp.net/api/v1/upload';
//
//   final http.Client _client;
//   final TokenStorage? _tokenStorage;
//
//   Uri get _imageUploadUri => Uri.parse('$_baseUrl/image');
//
//   Future<Map<String, dynamic>> uploadMedia({
//     required File file,
//     required DetectionMediaType type,
//   }) async {
//     // جلب التوكن من الـ Storage
//     final token = _tokenStorage?.getToken();
//
//     if (token == null || token.isEmpty) {
//       throw DetectionUploadException('Authentication token is missing. Please login again.');
//     }
//
//     final request = http.MultipartRequest('POST', _imageUploadUri);
//
//     // إضافة الـ Authorization Header بالصيغة الصحيحة
//     request.headers.addAll({
//       'Authorization': 'Bearer $token',
//       'Accept': 'application/json',
//     });
//
//     final fileExtension = file.path.split('.').last;
//     String mainType = _getMainType(type);
//
//     // إضافة الملف باستخدام الكي "File" كما في Swagger
//     request.files.add(
//       await http.MultipartFile.fromPath(
//         'File',
//         file.path,
//         contentType: MediaType(mainType, fileExtension),
//       ),
//     );
//
//     // إضافة الـ Path (1 للصور، 4 للفيديو، 5 للصوت)
//     request.fields['Path'] = _pathFor(type);
//
//     try {
//       final streamedResponse = await _client.send(request).timeout(const Duration(minutes: 2));
//       final response = await http.Response.fromStream(streamedResponse);
//
//       return _handleJsonResponse(response);
//     } on SocketException {
//       throw DetectionUploadException('No Internet connection or server is down.');
//     } catch (e) {
//       throw DetectionUploadException('Upload failed: $e');
//     }
//   }
//
//   String _getMainType(DetectionMediaType type) {
//     switch (type) {
//       case DetectionMediaType.image: return 'image';
//       case DetectionMediaType.video: return 'video';
//       case DetectionMediaType.audio: return 'audio';
//     }
//   }
//
//   String _pathFor(DetectionMediaType type) {
//     switch (type) {
//       case DetectionMediaType.image: return '1';
//       case DetectionMediaType.video: return '4';
//       case DetectionMediaType.audio: return '5';
//     }
//   }
//
//   Map<String, dynamic> _handleJsonResponse(http.Response response) {
//     final statusCode = response.statusCode;
//     Map<String, dynamic>? bodyJson;
//
//     try {
//       if (response.body.isNotEmpty) {
//         bodyJson = jsonDecode(response.body) as Map<String, dynamic>;
//       }
//     } catch (_) {}
//
//     if (statusCode >= 200 && statusCode < 300) {
//       return bodyJson ?? <String, dynamic>{};
//     }
//
//     final message = bodyJson?['message'] ?? bodyJson?['errors']?.toString() ?? 'Server error ($statusCode)';
//     throw DetectionUploadException(message.toString(), statusCode: statusCode);
//   }
//
//   // جوه كلاس DetectionUploadService
//   static const String _aiBaseUrl = 'https://unmarine-virgen-spiriferous.ngrok-free.dev';
//
//   Future<Map<String, dynamic>> getAiDetectionResult(File file, DetectionMediaType type) async {
//     // بنحدد الـ endpoint بناءً على نوع الميديا (دلوقت معانا الصوت، وبعدين هنزود الباقي)
//     String endpoint = '/Predict_Audio';
//     if (type == DetectionMediaType.image) endpoint = '/Predict_Image'; // لو جهزوه
//
//     var request = http.MultipartRequest('POST', Uri.parse('$_aiBaseUrl$endpoint'));
//
//     // الكي هنا 'audio' زي ما بعتوه في الصورة
//     request.files.add(await http.MultipartFile.fromPath('audio', file.path));
//
//     try {
//       final streamedResponse = await _client.send(request).timeout(const Duration(seconds: 30));
//       final response = await http.Response.fromStream(streamedResponse);
//
//       if (response.statusCode == 200) {
//         return jsonDecode(response.body) as Map<String, dynamic>;
//       } else {
//         throw Exception('AI Server Error: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Failed to connect to AI server: $e');
//     }
//   }
// }
//


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

  // الباك إند الأساسي (لرفع الملفات وحفظها)
  static const String _baseUrl = 'http://graduationapiproject.runasp.net/api/v1/upload';

  // لينك الـ AI الجديد (مريم نشأت والشباب)
  static const String _aiBaseUrl = 'https://manicure-sulphuric-sputter.ngrok-free.dev';

  final http.Client _client;
  final TokenStorage? _tokenStorage;

  // ---------------------------------------------------------
  // 1. وظيفة مناداة موديل الـ AI (الصور والصوت)
  // ---------------------------------------------------------
  Future<Map<String, dynamic>> getAiDetectionResult(File file, DetectionMediaType type) async {
    String finalUrl; // هنحدد اللينك كامل لكل نوع
    String fileKey;

    if (type == DetectionMediaType.image) {

      finalUrl = 'https://manicure-sulphuric-sputter.ngrok-free.dev/classify';
      fileKey = 'image'; // أو 'file' حسب ما اتفقتوا
    } else {

      finalUrl = 'https://unmarine-virgen-spiriferous.ngrok-free.dev/Predict_Audio';
      fileKey = 'audio';
    }

    var request = http.MultipartRequest('POST', Uri.parse(finalUrl));
    request.files.add(await http.MultipartFile.fromPath(fileKey, file.path));

    try {
      final streamedResponse = await _client.send(request).timeout(const Duration(minutes: 1));
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        // لو مطلع 404 هنا يبقى اللينك اللي فوق محتاج يتحدث من مريم
        throw DetectionUploadException('AI Server Error', statusCode: response.statusCode);
      }
    } catch (e) {
      throw DetectionUploadException('Failed to connect to AI server: $e');
    }
  }

  // ---------------------------------------------------------
  // 2. وظيفة الرفع للباك إند الأساسي (للأرشفة)
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
