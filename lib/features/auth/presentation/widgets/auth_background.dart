import 'package:flutter/material.dart';
import 'package:true_vision/core/responsive/app_responsive.dart';
import 'package:true_vision/core/theme/app_colors.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = AppResponsive.wp(context, 7);

    return Container(
      // التعديل هنا: نخليه ياخد طول وعرض الشاشة بالكامل
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.tvDB,
      ),
      child: SafeArea(
        // استخدمي bottom: false لو مش عاوزة الـ SafeArea تعمل فراغ تحت خالص مع الـ Background
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: child,
        ),
      ),
    );
  }
}