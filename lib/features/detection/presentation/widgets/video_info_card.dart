import 'package:flutter/material.dart';
import 'package:true_vision/features/detection/core/detection_theme.dart';

/// كارد يعرض معلومات الملف المُسح (اسم، تاريخ، مدة، حجم).
class VideoInfoCard extends StatelessWidget {
  const VideoInfoCard({
    super.key,
    required this.fileName,
    required this.scannedAt,
    required this.duration,
    required this.size,
  });

  final String fileName;
  final String scannedAt;
  final String duration;
  final String size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: DetectionTheme.surfaceDark,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: DetectionTheme.tealAccent.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.videocam_rounded,
              color: DetectionTheme.tealAccent,
              size: 26,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: const TextStyle(
                    color: DetectionTheme.tealAccent,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Scanned: $scannedAt',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.55),
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Duration: $duration • Size: $size',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.55),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
