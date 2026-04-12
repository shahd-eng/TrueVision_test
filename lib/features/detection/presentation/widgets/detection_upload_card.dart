import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:true_vision/features/detection/core/detection_theme.dart';

/// كارد "Tap to upload" بحدود منقطة للشاشات اللي فيها رفع ملف.
class DetectionUploadCard extends StatelessWidget {
  const DetectionUploadCard({
    super.key,
    required this.onTap,
    this.height = 240,
  });

  final VoidCallback onTap;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DottedBorder(
        color: DetectionTheme.primaryLight,
        strokeWidth: 2,
        dashPattern: const [3, 3],
        borderType: BorderType.RRect,
        radius: const Radius.circular(24),
        padding: const EdgeInsets.all(1),
        child: Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23),
            gradient: const LinearGradient(
              colors: [
                DetectionTheme.primaryLight,
                DetectionTheme.primaryDark,
              ],
              begin: Alignment.topLeft,
              end: Alignment(0.5, 1.5),
              stops: [0.1, 0.71],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.cloud_upload_rounded,
                  color: DetectionTheme.primaryLight,
                  size: 40,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Tap to upload your file',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Supports images, videos, and audio files',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
