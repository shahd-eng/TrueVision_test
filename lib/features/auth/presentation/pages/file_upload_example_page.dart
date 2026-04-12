import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../data/token_storage.dart';
import '../../data/file_upload_service.dart';

/// Example page showing how to upload files with authentication token
class FileUploadExamplePage extends StatefulWidget {
  const FileUploadExamplePage({super.key});

  @override
  State<FileUploadExamplePage> createState() => _FileUploadExamplePageState();
}

class _FileUploadExamplePageState extends State<FileUploadExamplePage> {
  late TokenStorage _tokenStorage;
  late FileUploadService _uploadService;
  bool _isUploading = false;
  String? _uploadStatus;

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    _tokenStorage = TokenStorage();
    await _tokenStorage.init();
    _uploadService = FileUploadService(tokenStorage: _tokenStorage);
  }

  Future<void> _pickAndUploadImage() async {
    try {
      // Check if user is authenticated
      if (!_tokenStorage.hasToken()) {
        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Please login first')));
        return;
      }

      // Pick image
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result == null || result.files.isEmpty) {
        return;
      }

      final filePath = result.files.first.path;
      if (filePath == null) {
        throw Exception('Could not get file path');
      }

      // Upload
      setState(() {
        _isUploading = true;
        _uploadStatus = 'Uploading...';
      });

      final response = await _uploadService.uploadImage(filePath: filePath);

      if (!mounted) return;
      setState(() {
        _uploadStatus = 'Upload successful: ${response['message'] ?? 'OK'}';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image uploaded successfully')),
      );
    } on UploadException catch (e) {
      if (!mounted) return;
      setState(() {
        _uploadStatus = 'Upload failed: ${e.message}';
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.message}')));
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _uploadStatus = 'Error: $e';
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload File')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: _isUploading ? null : _pickAndUploadImage,
              icon: const Icon(Icons.upload_file),
              label: const Text('Select and Upload Image'),
            ),
            if (_isUploading)
              const Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
            if (_uploadStatus != null)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  _uploadStatus!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
