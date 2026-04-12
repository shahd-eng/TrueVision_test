import 'package:flutter/material.dart';
import 'package:true_vision/core/constants/app_images.dart';
import 'package:true_vision/core/theme/app_colors.dart';

class ProtectionUploadCard extends StatelessWidget {
  const ProtectionUploadCard({
    super.key,
    required this.onTap,
    this.height = 200,
  });

  final VoidCallback onTap;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          // 1. اللون الخلفية الغامق زي الصورة (Navy500)
          color: AppColors.lb, // تقدري تستخدمي Color(0xFF0A1121) لو lb مش مضاية

          // 2. البوردر الخط المستقيم (Solid Border) بلون الـ Teal الشفاف
          border: Border.all(
            color: AppColors.primary500.withValues(alpha: 0.5),
            width: 1.5,
          ),

          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // أيقونة السحابة والدرع مع الـ Glow الأخضر
            Stack(
              alignment: Alignment.center,
              children: [
                // الـ Glow الخلفي
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.lb.withValues(alpha: 0.1),
                        blurRadius: 100,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                ),
                // الأيقونة الحقيقية
                Image.asset(
                  AppImages.protectionUpload, // اتأكدي إن الأيقونة صح
                  width: 100,
                ),
              ],
            ),

            const Text(
              'Tap to upload your media',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}