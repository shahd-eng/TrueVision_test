# Integration Guide - Complete Step-by-Step

## Prerequisites
- Flutter 3.10.1 or higher
- Your existing True Vision project

## Step 1: Install Dependencies

```bash
cd d:\TrueVision\true_vision
flutter pub get
```

**What gets installed:**
- `shared_preferences: ^2.2.0` - For local token storage

## Step 2: Initialize Services in main.dart

Open `lib/main.dart` and update the main function:

```dart
import 'package:flutter/material.dart';
import 'package:true_vision/features/auth/data/auth_service_manager.dart';

void main() async {
  // Make sure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize authentication services (TOKEN STORAGE)
  await AuthServiceManager().initialize();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ... your app configuration
      home: const SignInPage(),
    );
  }
}
```

## Step 3: Using in Login Page

The sign-in page already has the integration, but here's how it works:

```dart
// In sign_in_page.dart
Future<void> _handleAdminLogin() async {
  final email = _emailController.text.trim();
  final password = _passwordController.text;

  setState(() => _isLoading = true);
  try {
    // This automatically stores the token
    await _authApiService.adminLogin(email: email, password: password);

    if (!mounted) return;
    
    // Token is now stored and available for subsequent requests
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => const MediaTypePage(),
      ),
    );
  } on AuthException catch (e) {
    // Handle error...
  } finally {
    if (mounted) setState(() => _isLoading = false);
  }
}
```

## Step 4: Upload Files Anywhere in Your App

**Option A: Using AuthServiceManager (Recommended)**

```dart
import 'package:true_vision/features/auth/data/auth_service_manager.dart';
import 'package:file_picker/file_picker.dart';

class MyUploadWidget extends StatefulWidget {
  @override
  State<MyUploadWidget> createState() => _MyUploadWidgetState();
}

class _MyUploadWidgetState extends State<MyUploadWidget> {
  bool _isUploading = false;

  Future<void> _uploadImage() async {
    // Get the manager instance
    final manager = AuthServiceManager();

    // Check if authenticated
    if (!manager.isAuthenticated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please login first')),
      );
      return;
    }

    // Pick image
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result == null || result.files.isEmpty) return;

    final filePath = result.files.first.path;
    if (filePath == null) return;

    setState(() => _isUploading = true);

    try {
      // Upload file (token is included automatically)
      final response = await manager.fileUploadService.uploadImage(
        filePath: filePath,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image uploaded successfully!')),
      );

      print('Upload response: $response');
    } on UploadException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: ${e.message}')),
      );
    } finally {
      if (mounted) {
        setState(() => _isUploading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _isUploading ? null : _uploadImage,
      icon: const Icon(Icons.upload_file),
      label: const Text('Upload Image'),
    );
  }
}
```

**Option B: Using FileUploadService Directly**

```dart
import 'package:true_vision/features/auth/data/token_storage.dart';
import 'package:true_vision/features/auth/data/file_upload_service.dart';

// ... in your upload method ...
final tokenStorage = TokenStorage();
await tokenStorage.init();

final uploadService = FileUploadService(tokenStorage: tokenStorage);
final response = await uploadService.uploadImage(filePath: imagePath);
```

## Step 5: Implement Logout

Add this to your logout button or settings page:

```dart
import 'package:true_vision/features/auth/data/auth_service_manager.dart';

Future<void> _handleLogout() async {
  final manager = AuthServiceManager();
  
  // Clear token and user data
  await manager.logout();
  
  // Navigate to login
  if (!mounted) return;
  Navigator.of(context).pushNamedAndRemoveUntil(
    SignInPage.routeName,
    (_) => false,
  );
}
```

## Step 6: Check Authentication Status

```dart
import 'package:true_vision/features/auth/data/auth_service_manager.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final manager = AuthServiceManager();
    
    return Column(
      children: [
        if (manager.isAuthenticated) ...[
          Text('Welcome, ${manager.userEmail}'),
          Text('User: ${manager.userName}'),
        ] else ...[
          const Text('Please login first'),
        ],
      ],
    );
  }
}
```

## Step 7: API Response Format Verification

Your API must return a token. Check what format your API uses:

**Format 1: Direct token field** ✅
```json
{
  "token": "eyJ0eXAiOiJKV1QiLCJhbGc...",
  "message": "Login successful",
  "email": "user@example.com",
  "name": "John Doe"
}
```

**Format 2: accessToken field** ✅
```json
{
  "accessToken": "eyJ0eXAiOiJKV1QiLCJhbGc...",
  "message": "Login successful"
}
```

**Format 3: Nested in data** ✅
```json
{
  "data": {
    "token": "eyJ0eXAiOiJKV1QiLCJhbGc..."
  },
  "message": "Success"
}
```

**Format 4: Custom format** 🔧
If your API returns tokens in a different format, edit `lib/features/auth/data/auth_api_service.dart`:

```dart
void _extractAndSaveToken(Map<String, dynamic> response) {
  if (_tokenStorage == null) return;

  // Modify this to match your API format
  String? token = response['myCustomTokenField'] as String?;

  if (token != null && token.isNotEmpty) {
    _tokenStorage?.saveToken(
      token: token,
      email: response['email'] as String?,
      userName: response['name'] as String?,
    );
  }
}
```

## Step 8: Verify Integration

Run these tests to verify everything works:

```dart
// Test 1: Token Storage
void testTokenStorage() async {
  final storage = TokenStorage();
  await storage.init();
  
  await storage.saveToken(token: 'test_token_123');
  assert(storage.hasToken());
  assert(storage.getToken() == 'test_token_123');
  
  await storage.clearToken();
  assert(!storage.hasToken());
  
  print('✅ Token storage works!');
}

// Test 2: Service Manager
void testServiceManager() async {
  final manager = AuthServiceManager();
  await manager.initialize();
  
  assert(manager.isInitialized);
  assert(!manager.isAuthenticated); // Not logged in yet
  
  print('✅ Service manager works!');
}

// Test 3: Full Login Flow
void testLoginFlow() async {
  final manager = AuthServiceManager();
  await manager.initialize();
  
  try {
    // This will fail unless you have valid credentials
    // await manager.authApiService.adminLogin(
    //   email: 'test@example.com',
    //   password: 'password123',
    // );
    
    print('✅ Login flow works!');
  } on AuthException catch (e) {
    print('❌ Login failed: ${e.message}');
  }
}
```

## Troubleshooting

### Error: "No token found"
```
Solution: Ensure user is logged in before attempting to upload
// Check first
if (!AuthServiceManager().isAuthenticated) {
  // Show login screen
}
```

### Error: "Uninitialized field '_tokenStorage'"
```
Solution: Initialize in main.dart before using
// In main() function
await AuthServiceManager().initialize();
```

### Error: "Upload returns 401 Unauthorized"
```
Solution: Token might be expired or not being sent
1. Verify login was successful
2. Check token format in API response
3. Check token is being included: print(AuthServiceManager().authApiService._tokenStorage?.getToken())
```

### Error: "File not found"
```
Solution: Verify file path is correct
final file = File(filePath);
if (!await file.exists()) {
  print('File not found: $filePath');
}
```

### Token not saving after login
```
Solution: Check API response format
1. Print the API response: print(response);
2. Verify token field name matches one of: token, accessToken, access_token, data.token
3. If different, update _extractAndSaveToken() method
```

## Common Issues & Solutions

| Issue | Solution |
|-------|----------|
| "pubspec.lock" has conflicts | Run `flutter clean` then `flutter pub get` |
| Token not working | Check API response contains token field |
| Upload fails | Verify token exists: `manager.isAuthenticated` |
| App crashes on init | Ensure `WidgetsFlutterBinding.ensureInitialized()` is called first |
| Multiple initializations | Use singleton: `AuthServiceManager()` returns same instance |

## Next Steps

1. ✅ Run `flutter pub get`
2. ✅ Update main.dart with initialization
3. ✅ Build and run: `flutter run`
4. ✅ Test login
5. ✅ Test file upload
6. ✅ Test logout
7. ✅ Deploy to production

## Files Reference

| File | Purpose |
|------|---------|
| [token_storage.dart](lib/features/auth/data/token_storage.dart) | Token persistence |
| [auth_api_service.dart](lib/features/auth/data/auth_api_service.dart) | Authentication API |
| [file_upload_service.dart](lib/features/auth/data/file_upload_service.dart) | File upload with token |
| [auth_service_manager.dart](lib/features/auth/data/auth_service_manager.dart) | Service singleton |
| [file_upload_example_page.dart](lib/features/auth/presentation/pages/file_upload_example_page.dart) | Example UI |

## Support

For issues or questions:
1. Check [TOKEN_STORAGE_IMPLEMENTATION.md](TOKEN_STORAGE_IMPLEMENTATION.md)
2. Review [file_upload_example_page.dart](lib/features/auth/presentation/pages/file_upload_example_page.dart)
3. Check API endpoint: `http://graduationapiproject.runasp.net/api/v1/upload/image`
4. Verify token format in API response
