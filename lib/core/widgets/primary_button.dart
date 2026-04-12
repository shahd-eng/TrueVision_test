import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isOutlined = false,
    this.height,
    this.borderRadius = 12,
    this.textColor,
    this.backgroundColor,
    this.prefixIcon, // المتغير الجديد للأيقونة
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isOutlined;
  final double? height;
  final double borderRadius;
  final Color? textColor;
  final Color? backgroundColor;
  final Widget? prefixIcon; // ممكن تبعتي Icon أو Image.asset

  @override
  Widget build(BuildContext context) {
    final double buttonHeight = height ?? 52;
    const Color defaultMintGreen = AppColors.primary500;

    // ويدجت المحتوى الداخلي عشان نكررهاش في الـ Outlined و الـ ElevatedButton
    Widget buttonContent = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min, // عشان مياخدش مساحة أكبر من محتواه جوه السنتر
      children: [
        if (prefixIcon != null) ...[
          prefixIcon!,
          const SizedBox(width: 8), // مسافة بين الأيقونة والنص
        ],
        Text(
          label,
          style: TextStyle(
            color: isOutlined
                ? (textColor ?? defaultMintGreen)
                : (textColor ?? Colors.white),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );

    return SizedBox(
      width: double.infinity,
      height: buttonHeight,
      child: isOutlined
          ? OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(
            color: defaultMintGreen,
            width: 1,
          ),
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: buttonContent,
      )
          : ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Ink(
          decoration: BoxDecoration(
            color: backgroundColor ?? defaultMintGreen,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Container(
            alignment: Alignment.center,
            child: buttonContent,
          ),
        ),
      ),
    );
  }
}