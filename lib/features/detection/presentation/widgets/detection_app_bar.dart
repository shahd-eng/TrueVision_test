import 'package:flutter/material.dart';
import 'package:true_vision/core/theme/app_colors.dart';
import 'package:true_vision/features/detection/core/detection_theme.dart';


class DetectionAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DetectionAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.trailingIcon,
    this.onTrailingTap,
  });

  final String title;
  final VoidCallback? onBack;
  final IconData? trailingIcon;
  final VoidCallback? onTrailingTap;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.navy500,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            offset: const Offset(0, 3),
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: onBack ?? () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailingIcon != null
              ? IconButton(
                  onPressed: onTrailingTap,
                  icon: Icon(
                    trailingIcon!,
                    color: Colors.white,
                    size: 22,
                  ),
                )
              : const SizedBox(width: 48),
        ],
      ),
    );
  }
}
