import 'dart:async';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:true_vision/core/constants/app_images.dart';
import 'package:true_vision/core/responsive/app_responsive.dart';
import 'package:true_vision/features/detection/core/detection_media_type.dart';
import 'package:true_vision/features/detection/core/detection_theme.dart';
import 'package:true_vision/features/detection/presentation/pages/scan_result_page.dart';
import 'package:true_vision/features/detection/presentation/widgets/detection_app_bar.dart';

class AnalyzingContentPage extends StatefulWidget {
  const AnalyzingContentPage({
    super.key,
    required this.mediaType,
  });

  final DetectionMediaType mediaType;

  @override
  State<AnalyzingContentPage> createState() => _AnalyzingContentPageState();
}

class _AnalyzingContentPageState extends State<AnalyzingContentPage> {
  double _progress = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startProgress();
  }

  void _startProgress() {
    const int totalSteps = 100;
    const int stepMs = 50;
    int step = 0;

    _timer = Timer.periodic(const Duration(milliseconds: stepMs), (timer) {
      if (!mounted) return;
      step++;
      setState(() {
        _progress = step / totalSteps;
        if (_progress >= 1.0) {
          _progress = 1.0;
          timer.cancel();
          Future.delayed(const Duration(milliseconds: 400), () {
            if (!mounted) return;
            Navigator.of(context).pushReplacement(
              MaterialPageRoute<void>(
                builder: (_) => const ScanResultPage(),
              ),
            );
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  int get _percentage => 1 + (99 * _progress).round().clamp(0, 99);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DetectionTheme.backgroundDark,
      appBar: DetectionAppBar(
        title: 'Analyzing Content',
        onBack: () => Navigator.of(context).pop(),
        trailingIcon: Icons.psychology_alt_rounded,
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
                errorBuilder: (_, __, ___) => SizedBox(
                  width: 128,
                  height: 40,
                  child: Center(
                    child: Text(
                      'TRUE VISION',
                      style: TextStyle(
                        color: DetectionTheme.primaryLight,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppResponsive.hp(context, 3)),

              Text(
                'Your content is being analyzed...',
                style: TextStyle(
                  color: DetectionTheme.primaryLight,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                'This may take a few moments.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 14,
                ),
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
                    child: Image.asset(
                      AppImages.onboarding2,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: DetectionTheme.cardDark,
                        child: Center(
                          child: Icon(
                            Icons.image_outlined,
                            size: 48,
                            color: Colors.white.withValues(alpha: 0.4),
                          ),
                        ),
                      ),
                    ),
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
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    DetectionTheme.primaryLight,
                  ),
                ),
              ),
              SizedBox(height: AppResponsive.hp(context, 2)),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$_percentage%',
                    style: const TextStyle(
                      color: DetectionTheme.primaryLight,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Processing.',
                    style: TextStyle(
                      color: DetectionTheme.primaryLight,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Estimated time: 5 seconds',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 12,
                ),
              ),
              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: DetectionTheme.cancelRed,
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    foregroundColor: DetectionTheme.cancelRed,
                    backgroundColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
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
