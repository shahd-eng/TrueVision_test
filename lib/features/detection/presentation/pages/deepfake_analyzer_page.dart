import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:true_vision/core/responsive/app_responsive.dart';
import 'package:true_vision/features/detection/core/detection_media_type.dart';
import 'package:true_vision/features/detection/core/detection_theme.dart';
// استبدلي import الخدمة القديمة بـ AuthServiceManager
import 'package:true_vision/features/auth/data/auth_service_manager.dart';
import 'package:true_vision/features/detection/presentation/pages/analyzing_content_page.dart';
import 'package:true_vision/features/detection/presentation/widgets/detection_app_bar.dart';
import 'package:true_vision/features/detection/presentation/widgets/detection_bottom_nav.dart';
import 'package:true_vision/features/detection/presentation/widgets/detection_or_divider.dart';
import 'package:true_vision/features/detection/presentation/widgets/detection_upload_card.dart';

import 'choose_function_page.dart';
import 'history_page.dart';

class DeepfakeAnalyzerPage extends StatefulWidget {
  const DeepfakeAnalyzerPage({super.key, required this.mediaType});

  final DetectionMediaType mediaType;

  @override
  State<DeepfakeAnalyzerPage> createState() => _DeepfakeAnalyzerPageState();
}

class _DeepfakeAnalyzerPageState extends State<DeepfakeAnalyzerPage> {
  final TextEditingController _linkController = TextEditingController();


  bool _isUploading = false;

  @override
  void dispose() {
    _linkController.dispose();
    super.dispose();
  }

  Future<void> _pickAndUploadFile() async {
    if (_isUploading) return;
    print("DEBUG: Token is -> ${AuthServiceManager().tokenStorage.getToken()}");
    // 1. التأكد من وجود التوكن باستخدام المانجر الموحد
    if (!AuthServiceManager().isAuthenticated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please login first to upload media.')),
      );
      return;
    }

    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: _allowedExtensionsFor(widget.mediaType),
    );

    if (result == null || result.files.isEmpty) return;

    final String? path = result.files.single.path;
    if (path == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to read selected file path.')),
      );
      return;
    }

    final file = File(path);

    setState(() => _isUploading = true);

    try {
      // 2. استخدام الخدمة المربوطة بالمانجر مباشرة
      // ده بيضمن إن التوكن والـ Path والـ File يتبعتوا صح للسيرفر
      await AuthServiceManager().detectionUploadService.uploadMedia(
        file: file,
        type: widget.mediaType,
      );

      if (!mounted) return;
      Navigator.of(context).pushReplacement( // استخدمي pushReplacement عشان ميرجعش للتحميل تاني
        MaterialPageRoute<void>(
          builder: (_) => AnalyzingContentPage(mediaType: widget.mediaType),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      // إظهار رسالة الخطأ الحقيقية اللي جاية من الـ Service
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) {
        setState(() => _isUploading = false);
      }
    }
  }

  List<String> _allowedExtensionsFor(DetectionMediaType type) {
    switch (type) {
      case DetectionMediaType.image: return ['jpg', 'jpeg', 'png', 'webp'];
      case DetectionMediaType.video: return ['mp4', 'mov', 'mkv'];
      case DetectionMediaType.audio: return ['mp3', 'wav', 'm4a'];
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
            onTrailingTap: () {
              // مثلاً لو عاوزة تفتحي الـ History هنا
            },
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

                    // الكارد هينادي الدالة اللي بتستخدم المانجر
                    DetectionUploadCard(
                      onTap: _isUploading ? () {} : _pickAndUploadFile,
                    ),

                    SizedBox(height: AppResponsive.hp(context, 3)),
                    const DetectionOrDivider(),
                    SizedBox(height: AppResponsive.hp(context, 3)),

                    // الـ TextField والزرار بنفس المنطق...
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
      bottomNavigationBar: BottomNav(activePage: 'scan',
        
      ),
    );
  }

  Widget _buildLinkField() {
    return TextField(
      controller: _linkController,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        hintText: 'Paste the link here',
        hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 16),
        prefixIcon: Icon(Icons.link_rounded, color: DetectionTheme.primaryLight, size: 20),
        filled: true,
        fillColor: DetectionTheme.backgroundDark,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: DetectionTheme.primaryLight, width: 1.5),
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return GestureDetector(
      onTap: _isUploading ? null : _pickAndUploadFile,
      child: Opacity(
        opacity: _isUploading ? 0.7 : 1.0,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: DetectionTheme.primaryLight,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shield_rounded, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(
                _isUploading ? 'Uploading...' : 'Confirm & Analyze',
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}