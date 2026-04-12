# Quick Setup Guide - Token Storage & File Upload

## Step 1: Install Dependencies
```bash
cd d:\TrueVision\true_vision
flutter pub get
```

## Step 2: Initialize Services (in main.dart or splash screen)

```dart
import 'package:true_vision/features/auth/data/auth_service_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize auth services
  await AuthServiceManager().initialize();
  
  runApp(const MyApp());
}
```

## Step 3: Use in Your App

### Login Example
```dart
import 'package:true_vision/features/auth/data/auth_service_manager.dart';

final manager = AuthServiceManager();

try {
  // Login automatically stores the token
  await manager.authApiService.adminLogin(
    email: 'user@example.com',
    password: 'password123',
  );
  
  // Check authentication status
  if (manager.isAuthenticated) {
    print('Logged in as: ${manager.userEmail}');
  }
} on AuthException catch (e) {
  print('Login failed: ${e.message}');
}
```

### File Upload Example
```dart
import 'package:true_vision/features/auth/data/auth_service_manager.dart';

final manager = AuthServiceManager();

try {
  // Token is automatically included in the request
  final response = await manager.fileUploadService.uploadImage(
    filePath: '/path/to/image.jpg',
  );
  
  print('Upload successful: $response');
} on UploadException catch (e) {
  print('Upload failed: ${e.message}');
}
```

### Logout Example
```dart
final manager = AuthServiceManager();
await manager.logout();
print('Logged out');
```

## Step 4: Verify Token Extraction

The token extraction works automatically. Your API should return one of these formats:

```json
{
  "token": "YOUR_JWT_TOKEN",
  "message": "Login successful"
}
```

or

```json
{
  "accessToken": "YOUR_JWT_TOKEN",
  "message": "Login successful"
}
```

If your API returns tokens in a different field, modify [auth_api_service.dart](lib/features/auth/data/auth_api_service.dart#L164) in the `_extractAndSaveToken()` method.

## File Upload Endpoint

Your file upload endpoint should be:
```
POST http://graduationapiproject.runasp.net/api/v1/upload/image
```

The service automatically:
- Adds `Authorization: Bearer <token>` header
- Sends file as multipart form data
- Returns parsed JSON response

## Troubleshooting

### "No authentication token found"
- Make sure you've called `await AuthServiceManager().initialize()` first
- Make sure the user has successfully logged in
- Check that the API is returning a token in the response

### Token not being saved
- Verify the API response format contains a `token`, `accessToken`, or `access_token` field
- Check the `_extractAndSaveToken()` method in `auth_api_service.dart`
- Add custom field extraction if needed

### File upload fails with 401 Unauthorized
- Ensure the user is logged in with a valid token
- Check that `manager.isAuthenticated` returns true
- Verify the token is not expired

## Files Reference

- [TokenStorage](lib/features/auth/data/token_storage.dart) - Token persistence
- [AuthApiService](lib/features/auth/data/auth_api_service.dart) - Authentication API calls
- [FileUploadService](lib/features/auth/data/file_upload_service.dart) - File upload with token
- [AuthServiceManager](lib/features/auth/data/auth_service_manager.dart) - Centralized service manager
- [Example Page](lib/features/auth/presentation/pages/file_upload_example_page.dart) - Usage example

## Next Steps

1. ✅ Install dependencies with `flutter pub get`
2. ✅ Initialize services in main.dart
3. ✅ Update login/signup pages to use the services
4. ✅ Test login and verify token is stored
5. ✅ Test file uploads with the stored token
6. ✅ Customize token field extraction if needed for your API
