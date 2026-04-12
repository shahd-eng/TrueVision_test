import 'package:flutter/material.dart';

/// فاصل "OR" بين قسمين (مثل رفع ملف وزر لصق الرابط).
class DetectionOrDivider extends StatelessWidget {
  const DetectionOrDivider({
    super.key,
    this.dividerColor,
    this.textColor,
  });

  final Color? dividerColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final lineColor = dividerColor ?? Colors.white.withValues(alpha: 0.7);
    final labelColor = textColor ?? Colors.white.withValues(alpha: 0.7);

    return Row(
      children: [
        Expanded(
          child: Divider(color: lineColor, thickness: 2),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'OR',
            style: TextStyle(
              color: labelColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Divider(color: lineColor, thickness: 2),
        ),
      ],
    );
  }
}
