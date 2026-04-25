import 'dart:async';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:true_vision/core/constants/app_images.dart';
import 'package:true_vision/core/responsive/app_responsive.dart';
import 'package:true_vision/features/detection/core/detection_media_type.dart';
import 'package:true_vision/features/detection/core/detection_theme.dart';
import 'package:true_vision/features/detection/presentation/pages/scan_result_page.dart';
import 'package:true_vision/features/detection/presentation/widgets/detection_app_bar.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../auth/data/auth_service_manager.dart';

class AnalyzingContentPage extends StatefulWidget {
  const AnalyzingContentPage({
    super.key,
    required this.mediaType,
    required this.file,
  });

  final DetectionMediaType mediaType;
  final File file;

  @override
  State<AnalyzingContentPage> createState() => _AnalyzingContentPageState();
}

class _AnalyzingContentPageState extends State<AnalyzingContentPage> {
  double _progress = 0;
  Timer? _timer;
  Map<String, dynamic>? _aiResult;

  @override
  void initState() {
    super.initState();
    _startProgress();
    _callAiApi();
  }

  void _startProgress() {
    // الفيديو بياخد وقت أطول (حوالي دقيقة)، فبنخلي العداد أبطأ للفيديو
    // عشان ما يوصلش لـ 90% بسرعة ويفضل واقف كتير.
    final int stepMs = widget.mediaType == DetectionMediaType.video ? 400 : 50;
    int step = 0;

    _timer = Timer.periodic(Duration(milliseconds: stepMs), (timer) {
      if (!mounted) return;
      step++;

      setState(() {
        // العداد بيفضل يتحرك لحد 90% ويستنى رد السيرفر الحقيقي
        if (step <= 90) {
          _progress = step / 100;
        }

        // أول ما النتيجة تيجي (_aiResult != null) بنكمل لـ 100% وننقل الصفحة
        if (_aiResult != null && _progress >= 0.9) {
          _progress = 1.0;
          timer.cancel();
          Future.delayed(const Duration(milliseconds: 600), () {
            if (!mounted) return;
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => ScanResultPage(
                  result: _aiResult!,
                  file: widget.file,
                  mediaType: widget.mediaType,
                ),
              ),
            );
          });
        }
      });
    });
  }

  void _callAiApi() async {
    try {
      final result = await AuthServiceManager().detectionUploadService.getAiDetectionResult(
        widget.file,
        widget.mediaType,
      );

      if (mounted) {
        setState(() {
          _aiResult = result;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: ${e.toString()}"),
            backgroundColor: DetectionTheme.cancelRed,
          ),
        );
        Navigator.of(context).pop();
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // دالة عرض البريفيو حسب نوع الملف
  Widget _buildPreviewContent() {
    if (widget.mediaType == DetectionMediaType.image) {
      return Image.file(
        widget.file,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    } else if (widget.mediaType == DetectionMediaType.audio) {
      return Container(
        color: DetectionTheme.cardDark,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.audiotrack_rounded, size: 64, color: DetectionTheme.primaryLight),
            const SizedBox(height: 12),
            Text(
              widget.file.path.split('/').last,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    } else {
      // في حالة الفيديو
      return Container(
        color: Colors.black,
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.video_library_rounded, size: 64, color: DetectionTheme.primaryLight),
              SizedBox(height: 12),
              Text("Video File Ready", style: TextStyle(color: Colors.white70, fontSize: 14)),
            ],
          ),
        ),
      );
    }
  }

  int get _percentage => (_progress * 100).round().clamp(0, 100);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy500,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppResponsive.hp(context, 10)),
        child: Padding(
          padding: EdgeInsets.only(top: AppResponsive.hp(context, 3)),
          child: DetectionAppBar(
            title: 'Analyzing Content',
            onBack: () => Navigator.of(context).pop(),
            trailingIcon: Icons.info_outline_rounded,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppResponsive.wp(context, 5),
            vertical: AppResponsive.hp(context, 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: AppResponsive.hp(context, 3)),
              Image.asset(
                AppImages.logo,
                width: 128,
                height: 40,
                fit: BoxFit.contain,
              ),
              SizedBox(height: AppResponsive.hp(context, 3)),

              // نص متغير حسب نوع الميديا
              Text(
                widget.mediaType == DetectionMediaType.video
                    ? 'Analyzing video frames...'
                    : 'Your content is being analyzed...',
                style: const TextStyle(color: DetectionTheme.primaryLight, fontSize: 20, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: AppResponsive.hp(context, 3)),

              DottedBorder(
                color: DetectionTheme.primaryLight.withValues(alpha: 0.5),
                strokeWidth: 2,
                dashPattern: const [3, 3],
                borderType: BorderType.RRect,
                radius: const Radius.circular(16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: SizedBox(
                    width: double.infinity,
                    height: AppResponsive.hp(context, 28),
                    child: _buildPreviewContent(),
                  ),
                ),
              ),

              SizedBox(height: AppResponsive.hp(context, 4)),
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  value: _progress,
                  minHeight: 8,
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                  valueColor: const AlwaysStoppedAnimation<Color>(DetectionTheme.primaryLight),
                ),
              ),
              SizedBox(height: AppResponsive.hp(context, 2)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('$_percentage%', style: const TextStyle(color: DetectionTheme.primaryLight, fontSize: 24, fontWeight: FontWeight.w700)),
                  const SizedBox(width: 8),
                  const Text('Processing...', style: TextStyle(color: DetectionTheme.primaryLight, fontSize: 18)),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: DetectionTheme.cancelRed, width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    foregroundColor: DetectionTheme.cancelRed,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel Analysis'),
                ),
              ),
              SizedBox(height: AppResponsive.hp(context, 2)),
            ],
          ),
        ),
      ),
    );
  }
}