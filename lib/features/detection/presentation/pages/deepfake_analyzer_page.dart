import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:true_vision/core/responsive/app_responsive.dart';
import 'package:true_vision/features/detection/core/detection_media_type.dart';
import 'package:true_vision/features/detection/core/detection_theme.dart';
import 'package:true_vision/features/auth/data/auth_service_manager.dart';
import 'package:true_vision/features/detection/presentation/pages/analyzing_content_page.dart';
import 'package:true_vision/features/detection/presentation/widgets/detection_app_bar.dart';
import 'package:true_vision/features/detection/presentation/widgets/detection_bottom_nav.dart';
import 'package:true_vision/features/detection/presentation/widgets/detection_or_divider.dart';
import 'package:true_vision/features/detection/presentation/widgets/detection_upload_card.dart';

class DeepfakeAnalyzerPage extends StatefulWidget {
  const DeepfakeAnalyzerPage({super.key, required this.mediaType});

  final DetectionMediaType mediaType;

  @override
  State<DeepfakeAnalyzerPage> createState() => _DeepfakeAnalyzerPageState();
}

class _DeepfakeAnalyzerPageState extends State<DeepfakeAnalyzerPage> {
  final TextEditingController _linkController = TextEditingController();
  bool _isUploading = false;
  File? _selectedFile;

  @override
  void dispose() {
    _linkController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _uploadAndAnalyze() async {
    if (_selectedFile == null || _isUploading) return;

    setState(() => _isUploading = true);

    try {
      // محاكاة بسيطة للرفع
      await Future.delayed(const Duration(seconds: 1));

      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (_) => AnalyzingContentPage(
            mediaType: widget.mediaType,
            file: _selectedFile!,
          ),
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DetectionTheme.backgroundDark,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppResponsive.hp(context, 10)),
        child: Padding(
          padding: EdgeInsets.only(top: AppResponsive.hp(context, 4)),
          child: DetectionAppBar(
            title: 'Deepfake Analyzer',
            onBack: () => Navigator.of(context).pop(),
            trailingIcon: Icons.history_rounded,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppResponsive.wp(context, 4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppResponsive.hp(context, 1)),
                    const Center(
                      child: Text(
                        'Upload an image, video, or audio file to\ndetect if the content is AI-generated or\nmanipulated.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16, height: 1.5),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        'Stay aware. Stay protected.',
                        style: TextStyle(
                          color: DetectionTheme.primaryLight,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: AppResponsive.hp(context, 4)),

                    // الكارد المعدل بالكامل
                    DetectionUploadCard(
                      onTap: _isUploading ? () {} : _pickFile,
                      child: _buildUploadCardContent(),
                    ),

                    SizedBox(height: AppResponsive.hp(context, 3)),
                    const DetectionOrDivider(),
                    SizedBox(height: AppResponsive.hp(context, 3)),
                    _buildLinkField(),
                    SizedBox(height: AppResponsive.hp(context, 4)),
                    _buildConfirmButton(),
                    SizedBox(height: AppResponsive.hp(context, 2)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNav(activePage: 'scan'),
    );
  }

  // دالة بناء المحتوى الذكي للكارد
  Widget? _buildUploadCardContent() {
    if (_isUploading) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: Colors.white),
          const SizedBox(height: 16),
          const Text(
            "Preparing Analysis...",
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      );
    }

    if (_selectedFile != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // اسم الملف مع أيقونة النجاح
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _selectedFile!.path.split('/').last,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),

            // شكل Waveform احترافي مالي البوكس
            Container(
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(20, (index) {
                  return Container(
                    width: 4,
                    // أطوال متغيرة لعمل شكل نبضات صوتية
                    height: (index % 3 == 0) ? 40 : (index % 2 == 0) ? 25 : 15,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 15),
            const Text(
              "Tap to change selected file",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      );
    }

    return null; // يرجع للشكل الافتراضي للكارد
  }

  Widget _buildLinkField() {
    return TextField(
      controller: _linkController,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        hintText: 'Paste the link here',
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 16),
        prefixIcon: const Icon(Icons.link_rounded, color: DetectionTheme.primaryLight, size: 20),
        filled: true,
        fillColor: DetectionTheme.backgroundDark,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: DetectionTheme.primaryLight, width: 1.5),
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    bool isEnabled = _selectedFile != null && !_isUploading;

    return GestureDetector(
      onTap: isEnabled ? _uploadAndAnalyze : null,
      child: Opacity(
        opacity: isEnabled ? 1.0 : 0.5,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isEnabled ? DetectionTheme.primaryLight : Colors.grey[800],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shield_rounded, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(
                _isUploading ? 'Processing...' : 'Confirm & Analyze',
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}