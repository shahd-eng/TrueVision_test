import 'package:flutter/material.dart';
import 'package:true_vision/core/constants/app_images.dart';
import 'package:true_vision/core/responsive/app_responsive.dart';
import 'package:true_vision/core/theme/app_colors.dart';
import 'package:true_vision/core/widgets/primary_button.dart';
import 'package:true_vision/features/detection/core/detection_media_type.dart';
import 'package:true_vision/features/detection/presentation/pages/deepfake_analyzer_page.dart';
import 'package:true_vision/features/detection/presentation/widgets/detection_app_bar.dart';
import 'package:true_vision/features/detection/presentation/widgets/detection_type_card.dart';

class MediaTypePage extends StatefulWidget {
  const MediaTypePage({super.key});

  static const String routeName = '/media-type';

  @override
  State<MediaTypePage> createState() => _MediaTypePageState();
}

class _MediaTypePageState extends State<MediaTypePage> {
  DetectionMediaType? _selectedType;


  final List<DetectionMediaType> _orderedTypes = [
    DetectionMediaType.video,
    DetectionMediaType.image,
    DetectionMediaType.audio,
  ];

  String _imageFor(DetectionMediaType type) {
    switch (type) {
      case DetectionMediaType.video: return 'assets/videoAnalysis.png';
      case DetectionMediaType.image: return 'assets/imgAnalysis.png';
      case DetectionMediaType.audio: return 'assets/audioAnalysis.png';
    }
  }

  String _titleFor(DetectionMediaType type) {
    switch (type) {
      case DetectionMediaType.video: return 'Video Analysis';
      case DetectionMediaType.image: return 'Image Analysis';
      case DetectionMediaType.audio: return 'Audio Analysis';
    }
  }

  String _subtitleFor(DetectionMediaType type) {
    switch (type) {
      case DetectionMediaType.video: return 'Detect AI-generated or\nmanipulated videos.';
      case DetectionMediaType.image: return 'Identify AI-created or\naltered images.';
      case DetectionMediaType.audio: return 'Detect cloned voices and\nsynthetic audio.';
    }
  }

  void _onSelectType(DetectionMediaType type) {
    setState(() => _selectedType = _selectedType == type ? null : type);
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
            title: 'Media Type',
            onBack: () => Navigator.of(context).pop(),
            trailingIcon: Icons.info_outline_rounded,
            onTrailingTap: () {},
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    SizedBox(height: AppResponsive.hp(context, 2)),

                    // Header Section
                    const Text(
                      'POWERED BY ADVANCED AI TECHNOLOGY',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Image.asset(
                      AppImages.logo2,
                      width: AppResponsive.wp(context, 30),
                      height: AppResponsive.hp(context, 5),
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Select the type of media you want to analyze for\nAI manipulation.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),


                    for (final type in _orderedTypes) ...[
                      DetectionTypeCard(
                        imagePath: _imageFor(type),
                        title: _titleFor(type),
                        subtitle: _subtitleFor(type),
                        isSelected: _selectedType == type,
                        onTap: () => _onSelectType(type),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.black.withValues(alpha: 0.3), // لون خفيف جداً زي الصورة
              thickness: 2, // سمك الخط
              height: 3,    // المسافة اللي بياخدها من الـ Layout
            ),

            // Bottom Button
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: PrimaryButton(
                label: 'Continue',
                backgroundColor: _selectedType != null ? AppColors.primary500 : Colors.transparent,
                isOutlined: _selectedType == null,
                onPressed: _selectedType == null
                    ? null
                    : () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => DeepfakeAnalyzerPage(mediaType: _selectedType!),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}