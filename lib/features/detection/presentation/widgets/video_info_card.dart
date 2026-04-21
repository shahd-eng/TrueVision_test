import 'package:flutter/material.dart';
import 'package:true_vision/features/detection/core/detection_theme.dart';
import 'package:true_vision/features/detection/core/detection_media_type.dart'; // تأكدي من الـ import ده

/// كارد يعرض معلومات الملف المُسح (اسم، تاريخ، مدة، حجم) بشكل ديناميكي.
class VideoInfoCard extends StatelessWidget {
  const VideoInfoCard({
    super.key,
    required this.fileName,
    required this.scannedAt,
    required this.duration,
    required this.size,
    required this.mediaType, // ضفنا ده عشان نعرف نوع الميديا
  });

  final String fileName;
  final String scannedAt;
  final String duration;
  final String size;
  final DetectionMediaType mediaType;

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
          // أيقونة الميديا الديناميكية
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: DetectionTheme.tealAccent.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              // اختيار الأيقونة بناءً على النوع
              mediaType == DetectionMediaType.image
                  ? Icons.image_rounded
                  : mediaType == DetectionMediaType.audio
                  ? Icons.audiotrack_rounded
                  : Icons.videocam_rounded,
              color: DetectionTheme.tealAccent,
              size: 28,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // اسم الملف
                Text(
                  fileName,
                  style: const TextStyle(
                    color: DetectionTheme.tealAccent,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                // وقت الفحص
                Text(
                  'Scanned: $scannedAt',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.55),
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 2),
                // الحجم والنوع/المدة
                Text(
                  mediaType == DetectionMediaType.image
                      ? 'Format: Image • $size' // لو صورة مش هنكتب Duration
                      : 'Duration: $duration • $size',
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