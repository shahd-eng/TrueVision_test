import '../../detection/data/detection_upload_service.dart';
import 'token_storage.dart';
import 'auth_api_service.dart';


class AuthServiceManager {
  static final AuthServiceManager _instance = AuthServiceManager._internal();
  factory AuthServiceManager() => _instance;
  AuthServiceManager._internal();

  late TokenStorage tokenStorage;
  late AuthApiService authApiService;
  late DetectionUploadService detectionUploadService; // تغيير النوع هنا

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    tokenStorage = TokenStorage();
    await tokenStorage.init();

    authApiService = AuthApiService(tokenStorage: tokenStorage);

    // ربط الخدمة الجديدة بنفس الـ tokenStorage
    detectionUploadService = DetectionUploadService(tokenStorage: tokenStorage);

    _initialized = true;
  }

  bool get isInitialized => _initialized;
  bool get isAuthenticated => tokenStorage.hasToken();
  String? get userEmail => tokenStorage.getUserEmail();
  String? get userName => tokenStorage.getUserName();

  Future<void> logout() async {
    await tokenStorage.clearToken();
  }
}