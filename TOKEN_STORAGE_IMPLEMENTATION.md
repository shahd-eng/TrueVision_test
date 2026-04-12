# Token Storage and File Upload Implementation

## Overview
This implementation adds secure token storage to your authentication system, allowing you to:
- Automatically store access tokens after login/signup
- Use stored tokens for authenticated API requests
- Upload files with automatic token inclusion

## Files Created/Modified

### New Files
1. **`lib/features/auth/data/token_storage.dart`**
   - Service for storing and retrieving authentication tokens
   - Uses SharedPreferences for local storage
   - Methods: `saveToken()`, `getToken()`, `hasToken()`, `clearToken()`

2. **`lib/features/auth/data/authenticated_http_client.dart`**
   - HTTP client that automatically includes the access token in requests
   - Useful for extending HTTP client behavior with authorization

3. **`lib/features/auth/data/file_upload_service.dart`**
   - Service for uploading files with automatic token inclusion
   - Methods: `uploadImage()`, `uploadImages()`
   - Endpoint: `http://graduationapiproject.runasp.net/api/v1/upload/image`

4. **`lib/features/auth/presentation/pages/file_upload_example_page.dart`**
   - Example page showing how to use the upload service
   - Demonstrates file picker integration and error handling

### Modified Files
1. **`pubspec.yaml`**
   - Added `shared_preferences: ^2.2.0` dependency

2. **`lib/features/auth/data/auth_api_service.dart`**
   - Added `TokenStorage` parameter to constructor
   - Added `_extractAndSaveToken()` method to automatically extract and save tokens from API responses
   - Tokens are extracted with support for common field names: `token`, `accessToken`, `access_token`, `data.token`

3. **`lib/features/auth/presentation/pages/sign_in_page.dart`**
   - Initialized `TokenStorage` in `initState()`
   - Passes `TokenStorage` to `AuthApiService` for automatic token storage

4. **`lib/features/auth/presentation/pages/sign_up_page.dart`**
   - Initialized `TokenStorage` in `initState()`
   - Passes `TokenStorage` to `AuthApiService` for automatic token storage

## How It Works

### Login Flow
1. User enters credentials and taps login
2. `AuthApiService.adminLogin()` calls the API
3. API response is received
4. `_extractAndSaveToken()` automatically extracts the token and saves it
5. Token is now available for subsequent requests

### File Upload Flow
1. User selects file to upload
2. `FileUploadService.uploadImage()` is called
3. Service retrieves the stored token automatically
4. Token is added to request headers: `Authorization: Bearer <token>`
5. File is uploaded to `/api/v1/upload/image`

## Usage Examples

### Access Stored Token
```dart
final tokenStorage = TokenStorage();
await tokenStorage.init();

final token = tokenStorage.getToken();
if (tokenStorage.hasToken()) {
  print('User is logged in');
}
```

### Upload File
```dart
final tokenStorage = TokenStorage();
await tokenStorage.init();

final uploadService = FileUploadService(tokenStorage: tokenStorage);

try {
  final response = await uploadService.uploadImage(
    filePath: '/path/to/image.jpg',
  );
  print('Upload successful: $response');
} on UploadException catch (e) {
  print('Upload failed: ${e.message}');
}
```

### Multiple File Upload
```dart
final responses = await uploadService.uploadImages(
  filePaths: ['/path/file1.jpg', '/path/file2.jpg'],
);
```

### Logout
```dart
final tokenStorage = TokenStorage();
await tokenStorage.init();
await tokenStorage.clearToken();
```

## Token Extraction Logic

The system automatically extracts tokens from API responses by checking these fields in order:
1. `response['token']`
2. `response['accessToken']`
3. `response['access_token']`
4. `response['data']['token']`

If your API returns tokens in a different field, modify the `_extractAndSaveToken()` method in `auth_api_service.dart`.

## Important Notes

- **Token Initialization**: Always call `await tokenStorage.init()` before using the TokenStorage service
- **Automatic Authorization**: FileUploadService automatically includes the token in request headers
- **Error Handling**: Check for `UploadException` and `AuthException` when handling API calls
- **Local Storage**: Tokens are stored in SharedPreferences (local device storage)
- **Token Retrieval**: For file uploads, ensure user is logged in before attempting to upload

## API Response Format

Your API should return tokens in one of these formats:

```json
// Format 1: Direct token field
{
  "token": "eyJ0eXAiOiJKV1QiLCJhbGc...",
  "message": "Login successful"
}

// Format 2: AccessToken field
{
  "accessToken": "eyJ0eXAiOiJKV1QiLCJhbGc...",
  "message": "Login successful"
}

// Format 3: Nested in data
{
  "data": {
    "token": "eyJ0eXAiOiJKV1QiLCJhbGc..."
  },
  "message": "Login successful"
}
```

## Next Steps

1. Run `flutter pub get` to install the new `shared_preferences` package
2. Test login/signup to verify tokens are being stored
3. Test file uploads to verify tokens are being included in requests
4. Customize token field names if your API uses different field names
5. Implement logout functionality using `tokenStorage.clearToken()`

## Security Considerations

- SharedPreferences stores data in plain text on the device
- For highly sensitive apps, consider using `flutter_secure_storage` instead
- Always use HTTPS for API communications
- Implement token refresh logic if needed for long-lived tokens
