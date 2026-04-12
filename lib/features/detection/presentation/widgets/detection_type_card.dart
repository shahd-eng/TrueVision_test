import 'package:flutter/material.dart';
import 'package:true_vision/features/detection/core/detection_theme.dart';

import '../../../../core/theme/app_colors.dart';

class DetectionTypeCard extends StatelessWidget {
  const DetectionTypeCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  final String imagePath;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  static const double fixedHeight = 130;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: fixedHeight,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? null : AppColors.lb,

          gradient: isSelected
              ? LinearGradient(
            colors: [
              AppColors.tvDB2,
             AppColors.tvDB,
            ],
            begin: const Alignment(-0.9, -0.3),
            end: const Alignment(-0.81, 1),
            stops: const [0, 1],
          )
              : null,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppColors.primary500
                :AppColors.shadowColor.withValues(alpha: 0.2),
            width: isSelected ? 1 : 1,
          ),
        ),
        child: Row(
          children: [

            Container(
              width: 85,
              height: 85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover, // يملأ الـ Container
              ),
            ),
            const SizedBox(width: 16),

            // Text Content
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 13,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}