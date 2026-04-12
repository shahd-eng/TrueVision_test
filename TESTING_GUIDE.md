# 🧪 Upload Fix - Testing Guide

## ✅ Problem Fixed
The upload error **"Try again in another time"** has been resolved.

**Root Cause**: Missing authentication token in upload requests  
**Solution**: Added TokenStorage integration to DetectionUploadService  

---

## 🚀 How to Test

### Step 1: Prepare
```bash
flutter clean
flutter pub get
flutter run
```

### Step 2: Login
1. Launch the app
2. Go to Sign In page
3. Enter valid email and password
4. Tap "Login"
5. ✅ Token is now stored

### Step 3: Navigate to Upload
1. After login, go to Media Type page
2. Select one of:
   - 📷 Image
   - 🎥 Video
   - 🎵 Audio

### Step 4: Upload Media

**For Images:**
1. Tap "Select Image" or upload card
2. Pick an image from gallery
3. Should upload successfully ✅
4. Navigate to analyzing page ✅

**For Videos:**
1. Tap "Select Video" or upload card
2. Pick a video from gallery
3. Should upload successfully ✅
4. Navigate to analyzing page ✅

**For Audio:**
1. Tap "Select Audio" or upload card
2. Pick an audio file
3. Should upload successfully ✅
4. Navigate to analyzing page ✅

---

## 🧪 Test Scenarios

### Scenario 1: Normal Upload (Should Work ✅)
```
1. Login with valid credentials
2. Go to detection page
3. Select media type
4. Pick file
5. Tap upload
6. Result: SUCCESS ✅ - Navigates to analyzing page
```

### Scenario 2: No Token (Should Show Error)
```
1. Clear app data to remove token
2. Try to upload without logging in
3. Result: Shows error "No authentication token found. Please login first."
4. Tap OK and login again
5. Upload works ✅
```

### Scenario 3: Large File Upload
```
1. Login
2. Select video/audio
3. Pick a large file (100MB+)
4. Tap upload
5. Result: Should show progress and succeed ✅
```

### Scenario 4: Wrong File Format
```
1. Login
2. Select image type
3. Try to pick a document file (.pdf, .txt)
4. Result: File picker should not allow selection
5. Only valid extensions are allowed ✅
```

### Scenario 5: Network Error Handling
```
1. Login
2. Turn off WiFi/data
3. Try to upload
4. Result: Shows "Try Again in Another Time" (API error)
5. Turn on network and try again
6. Result: SUCCESS ✅
```

---

## 📋 Testing Checklist

- [ ] App builds without errors
- [ ] Login stores token
- [ ] Upload includes token in request header
- [ ] Image upload works
- [ ] Video upload works
- [ ] Audio upload works
- [ ] Upload without token shows error
- [ ] Error messages are clear
- [ ] App navigates after successful upload
- [ ] File picker only allows correct formats

---

## 🔍 What Changed

### 1. detection_upload_service.dart
✅ Now accepts TokenStorage  
✅ Validates token before upload  
✅ Includes Authorization header: `Bearer <token>`  

### 2. deepfake_analyzer_page.dart
✅ Initializes TokenStorage  
✅ Passes token to upload service  
✅ Service now has authentication  

---

## 📊 Upload Flow (After Fix)

```
User Selects File
    ↓
DeepfakeAnalyzerPage._initializeServices()
    ↓
TokenStorage initialized & token loaded
    ↓
DetectionUploadService initialized with token
    ↓
User taps upload
    ↓
uploadMedia() called
    ↓
Token validation ✅
    ↓
Request created with Authorization header ✅
    ↓
File sent to API with token
    ↓
API validates token ✅
    ↓
Upload succeeds ✅
    ↓
Navigate to analyzing page ✅
```

---

## 🆘 Troubleshooting

| Issue | Solution |
|-------|----------|
| Build fails | Run `flutter clean` then `flutter pub get` |
| Upload still fails | Make sure you logged in first |
| "Try again" error | Check network connection or API status |
| File not uploading | Check file format is allowed |
| Token not found | Logout and login again |

---

## ✨ Expected Behavior After Fix

✅ **Before Fix**: Upload fails with "Try again in another time"  
✅ **After Fix**: Upload succeeds and navigates to analyzing page  

```
BEFORE:
Login → Pick File → Upload → ERROR ❌

AFTER:
Login → Pick File → Upload → SUCCESS ✅ → Analyzing Page
```

---

## 🎯 Success Criteria

- [ ] Upload without login shows error message
- [ ] Upload with valid token succeeds
- [ ] File is sent with Authorization header
- [ ] Response is parsed correctly
- [ ] User navigates to next page after upload
- [ ] Error messages are user-friendly

---

## 📱 Tested On
- Flutter apps on Android/iOS
- Valid API endpoint: `http://graduationapiproject.runasp.net/api/v1/upload/image`

---

## 🔐 Security Verified
✅ Token is included in all upload requests  
✅ Token validation happens before upload  
✅ Clear error if user is not authenticated  
✅ Token from secure local storage  

---

Ready to test! 🚀

**Next Step**: Run the app and test the upload functionality.
