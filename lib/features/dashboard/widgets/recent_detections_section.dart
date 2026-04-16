import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';
import '../../../domain/entities/recent_detection.dart';
import '../../../core/widgets/app_container.dart';

class RecentDetectionsSection extends StatelessWidget {
  final List<RecentDetection> items;

  const RecentDetectionsSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Detections',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                'View All',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF3D9889),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) =>
              _RecentDetectionCard(detection: items[index]),
        ),
      ],
    );
  }
}

class _RecentDetectionCard extends StatelessWidget {
  final RecentDetection detection;

  const _RecentDetectionCard({required this.detection});

  Color _pillColor(String label) {
    switch (label.toLowerCase()) {
      case 'deepfake':
        return const Color(0xFFFEE2E2); // reddish-pink
      case 'synthetic':
        return const Color(0xFFDBEAFE); // light blue
      case 'enhanced':
        return const Color(0xFFDCFCE7); // light green
      case 'face swap':
        return const Color(0xFFFEF9C3); // light yellow
      default:
        return const Color(0xFFB0BEC5); // grey fallback
    }
  }

  Color _pillTextColor(String label) {
    switch (label.toLowerCase()) {
      case 'deepfake':
        return const Color(0xFF991B1B);
      case 'synthetic':
        return const Color(0xFF1E40AF);
      case 'enhanced':
        return const Color(0xFF166534);
      case 'face swap':
        return const Color(0xFF854D0E);
      default:
        return const Color(0xFF37474F);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pillBg = _pillColor(detection.label);
    final pillText = _pillTextColor(detection.label);

    return AppContainer(
      padding: 14,
      borderRadius: 12,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.cardContentBg,
                image: detection.imagePath != null
                    ? DecorationImage(
                        image: AssetImage(detection.imagePath!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              alignment: Alignment.center,
              child: detection.imagePath == null
                  ? Icon(
                      Icons.image_outlined,
                      color: AppColors.lightTextSecondary,
                    )
                  : null,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: pillBg,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        detection.label,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: pillText,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        detection.platform,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFFFFFFFF),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  detection.title,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3D9889),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  detection.subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFFFFFFF),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF9CA3AF)),
        ],
      ),
    );
  }
}
