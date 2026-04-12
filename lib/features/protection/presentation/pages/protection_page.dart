import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:true_vision/core/constants/app_images.dart';
import 'package:true_vision/core/responsive/app_responsive.dart';
import 'package:true_vision/core/theme/app_colors.dart';
import 'package:true_vision/core/widgets/primary_button.dart';
import 'package:true_vision/features/detection/presentation/pages/choose_function_page.dart';
import 'package:true_vision/features/detection/presentation/pages/history_page.dart';
import 'package:true_vision/features/detection/presentation/widgets/detection_app_bar.dart';
import 'package:true_vision/features/detection/presentation/widgets/detection_bottom_nav.dart';
import 'package:true_vision/features/protection/presentation/widgets/protection_upload_card.dart';

class ProtectionPage extends StatefulWidget {
  const ProtectionPage({super.key});

  @override
  State<ProtectionPage> createState() => _ProtectionPageState();
}

class _ProtectionPageState extends State<ProtectionPage> {
  File? _selectedFile;
  String? _pickedFileName;
  bool _isUploading = false;
  double _uploadProgress = 0.0;
  Timer? _uploadTimer;

  @override
  void dispose() {
    _uploadTimer?.cancel();
    super.dispose();
  }

  Future<void> _pickAndUploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.media,
    );

    if (result != null) {
      final PlatformFile file = result.files.first;

      setState(() {
        _pickedFileName = file.name;
        _selectedFile = File(file.path!);
        _isUploading = true;
        _uploadProgress = 0.0;
      });

      _uploadTimer?.cancel();
      _uploadTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        setState(() {
          _uploadProgress += 0.05;
          if (_uploadProgress >= 1.0) {
            _uploadProgress = 1.0;
            _isUploading = false;
            timer.cancel();
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy500,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppResponsive.hp(context, 10)),
        child: Padding(
          padding: EdgeInsets.only(top: AppResponsive.hp(context, 4)),
          child: DetectionAppBar(
            title: 'Ai Protection',
            onBack: () => Navigator.of(context).pop(),
            // استخدام الـ Widget الجديد لعرض الصورة في الـ AppBar
            trailingIcon:Icons.shield_sharp,
          ),
        ),
      ),
      // SafeArea + SingleChildScrollView يضمن إن كل المحتوى يسكرول مع بعضه
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'Upload your media to generate a protected\nversion resistant to AI manipulation.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 8),
              const Text(
                'Supported formats: MP4, JPG, PNG, MP3, WAV',
                style: TextStyle(color: AppColors.primary500, fontSize: 12),
              ),
              const SizedBox(height: 32),

              // --- منطقة الرفع / التحميل / المعاينة ---
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: _isUploading
                    ? _buildUploadingState()
                    : (_uploadProgress == 1.0 && _selectedFile != null)
                    ? _buildPreviewState()
                    : ProtectionUploadCard(onTap: _pickAndUploadFile),
              ),

              const SizedBox(height: 16),

              // --- الـ Divider الجرادينت المتلاشي ---
              _buildGradientDivider(),

              const SizedBox(height: 16),

              // --- بوكس النتيجة (Placeholder) ---
              _buildResultBox(),

              const SizedBox(height: 40),

              // --- زرار التأكيد (بقى داخل السكرول) ---
              PrimaryButton(
                prefixIcon: Image.asset(AppImages.shield, width: 18),
                label: 'Confirm & Protect',
                onPressed: (_uploadProgress == 1.0 && !_isUploading) ? () {} : null,
                backgroundColor: (_uploadProgress == 1.0 && !_isUploading)
                    ? AppColors.primary500
                    : Colors.transparent,
                isOutlined: (_uploadProgress < 1.0 || _isUploading),
              ),

              const SizedBox(height: 30), // مسافة أمان إضافية تحت الزرار
            ],
          ),
        ),
      ),
      // الناف بار يفضل ثابت في مكان مخصص له تحت الـ Scaffold
      bottomNavigationBar: BottomNav(activePage: 'scan',

        

      ),
    );
  }

  // ميثود بناء الجرادينت ديفايدر (يتلاشى للأطراف)
  Widget _buildGradientDivider() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary500.withValues(alpha: 0.8), AppColors.navy500],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Icon(Icons.sync, color: const Color(0xFF2F8F83), size: 24),
        ),
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary500.withValues(alpha: 0.8), AppColors.navy500],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ميثود بناء بوكس النتيجة الشفاف
  Widget _buildResultBox() {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        color: const Color(0xFF1A2332).withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary500.withValues(alpha: 0.15), width: 1.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImages.protectedUpload, width: 60),
          const SizedBox(height: 12),
          const Text(
            'Protected file will appear here',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadingState() {
    return Container(
      key: const ValueKey(1),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: const Color(0xFF121F36).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF2F8F83).withValues(alpha: 0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Uploading media...', style: TextStyle(color: Colors.white, fontSize: 18)),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: LinearProgressIndicator(
              value: _uploadProgress,
              backgroundColor: Colors.white10,
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2F8F83)),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 12),
          Text('${(_uploadProgress * 100).toInt()}%', style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildPreviewState() {
    return Container(
      key: const ValueKey(2),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF2F8F83), width: 1.5),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.file(_selectedFile!, fit: BoxFit.cover),
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () => setState(() {
                _selectedFile = null;
                _uploadProgress = 0.0;
              }),
              child: const CircleAvatar(
                backgroundColor: Colors.black54,
                child: Icon(Icons.close, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}