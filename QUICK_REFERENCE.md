# Quick Reference Card

## 🚀 Quick Start (5 minutes)

### 1. Install
```bash
flutter pub get
```

### 2. Initialize (in main.dart)
```dart
import 'package:true_vision/features/auth/data/auth_service_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthServiceManager().initialize();
  runApp(const MyApp());
}
```

### 3. Use It
```dart
// Login (token auto-stored)
await authService.adminLogin(email: 'x@y.com', password: 'pass');

// Upload (token auto-included)
await fileUploadService.uploadImage(filePath: 'path/to/image.jpg');

// Check auth
if (AuthServiceManager().isAuthenticated) { ... }

// Logout
await AuthServiceManager().logout();
```

---

## 📚 Complete Reference

### AuthServiceManager (Singleton)
```dart
// Get instance
final manager = AuthServiceManager();

// Services
manager.tokenStorage          // Token storage
manager.authApiService        // Auth API calls
manager.fileUploadService     // File uploads

// Properties
manager.isInitialized         // bool
manager.isAuthenticated       // bool
manager.userEmail             // String?
manager.userName              // String?

// Methods
await manager.initialize()    // Setup
await manager.logout()        // Clear data
```

### TokenStorage
```dart
final storage = TokenStorage();
await storage.init();

// Methods
await storage.saveToken(token, email, userName)
String? storage.getToken()
bool storage.hasToken()
String? storage.getUserEmail()
String? storage.getUserName()
await storage.clearToken()
```

### AuthApiService
```dart
final service = AuthApiService(tokenStorage: tokenStorage);

// Methods (auto-store token)
await service.adminLogin(email, password)
await service.register(email, firstName, lastName, password)
await service.externalLoginWithGoogle(token)
await service.requestOtp(email)
await service.validateOtp(email, otpCode)
await service.resetPassword(email, password, confirmPassword)
```

### FileUploadService
```dart
final service = FileUploadService(tokenStorage: tokenStorage);

// Methods (auto-include token)
await service.uploadImage(filePath, fileName)
await service.uploadImages(filePaths)

// Exceptions
try { ... }
on UploadException catch (e) { ... }
```

---

## 🔧 Common Tasks

### Check if logged in
```dart
if (AuthServiceManager().isAuthenticated) {
  print('User is logged in');
}
```

### Get user info
```dart
print(AuthServiceManager().userEmail);    // user@example.com
print(AuthServiceManager().userName);     // John Doe
```

### Upload and handle errors
```dart
try {
  await AuthServiceManager().fileUploadService.uploadImage(
    filePath: '/path/to/image.jpg',
  );
} on UploadException catch (e) {
  print('Upload failed: ${e.message}');
} on Exception catch (e) {
  print('Error: $e');
}
```

### Logout user
```dart
await AuthServiceManager().logout();
Navigator.of(context).pushNamedAndRemoveUntil(
  SignInPage.routeName,
  (_) => false,
);
```

### Pick file and upload
```dart
import 'package:file_picker/file_picker.dart';

final result = await FilePicker.platform.pickFiles(type: FileType.image);
if (result != null) {
  await AuthServiceManager().fileUploadService.uploadImage(
    filePath: result.files.first.path!,
  );
}
```

---

## 🐛 Troubleshooting

| Problem | Solution |
|---------|----------|
| "No token found" | Login first: `manager.isAuthenticated` |
| "Uninitialized field" | Call `initialize()` in main.dart |
| "401 Unauthorized" | Token expired, logout and login again |
| "File not found" | Check file path is correct and file exists |
| Import errors | Run `flutter pub get` |
| Build errors | Run `flutter clean` then `flutter pub get` |

---

## 📁 Key Files

| File | Purpose |
|------|---------|
| `token_storage.dart` | Token persistence |
| `auth_api_service.dart` | Login/signup API |
| `file_upload_service.dart` | File uploads |
| `auth_service_manager.dart` | Service manager |
| `sign_in_page.dart` | Login UI |
| `sign_up_page.dart` | Signup UI |
| `file_upload_example_page.dart` | Upload example |

---

## 🔐 API Expectations

Your API should return tokens like:
```json
{
  "token": "eyJ0eXAiOiJKV1Q...",
  "message": "Success"
}
```

File upload endpoint:
```
POST /api/v1/upload/image
Header: Authorization: Bearer <token>
```

---

## ✅ Checklist

- [ ] Run `flutter pub get`
- [ ] Update main.dart with initialization
- [ ] Build: `flutter run`
- [ ] Test login
- [ ] Test file upload
- [ ] Test logout
- [ ] Verify token in SharedPreferences (using debugger)

---

## 📞 Documentation

- Full guide: `INTEGRATION_GUIDE.md`
- Technical docs: `TOKEN_STORAGE_IMPLEMENTATION.md`
- Setup: `SETUP_GUIDE.md`
- Changes: `CHANGES_SUMMARY.md`

---

## 🎯 Remember

1. **Always initialize** in main.dart before using
2. **Token is auto-stored** after login
3. **Token is auto-included** in uploads
4. **Check authentication** with `isAuthenticated`
5. **Handle exceptions** with try-catch blocks
6. **Clear token** with `logout()` on sign out

---

**Ready to upload files? You're all set!** 🚀
