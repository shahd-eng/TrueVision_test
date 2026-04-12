import 'package:flutter/material.dart';
import 'package:true_vision/core/constants/app_images.dart';
import 'package:true_vision/core/responsive/app_responsive.dart';
import 'package:true_vision/features/detection/core/detection_theme.dart';
import 'package:true_vision/features/detection/presentation/widgets/detection_app_bar.dart';
import 'package:true_vision/features/detection/presentation/widgets/detection_bottom_nav.dart';
import 'package:true_vision/features/detection/presentation/widgets/segment_thumbnail.dart';
import 'package:true_vision/features/detection/presentation/widgets/video_info_card.dart';

class ScanResultPage extends StatelessWidget {
  const ScanResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DetectionTheme.backgroundDark,
      appBar: DetectionAppBar(
        title: 'Scan Result',
        onBack: () => Navigator.of(context).pop(),
        trailingIcon: Icons.info_outline_rounded,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: AppResponsive.wp(context, 4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppResponsive.hp(context, 3)),

            const VideoInfoCard(
              fileName: 'interview_video_final.mp4',
              scannedAt: 'Dec 28, 2024 at 2:45 PM',
              duration: '2:34 min',
              size: '45.2 MB',
            ),

            SizedBox(height: AppResponsive.hp(context, 2)),

            _VideoPreview(imagePath: AppImages.onboarding2),

            SizedBox(height: AppResponsive.hp(context, 2.5)),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.share_rounded, size: 20),
                label: const Text('Share Result'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: DetectionTheme.primaryLight,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.download_rounded,
                  size: 20,
                  color: DetectionTheme.textOnDark,
                ),
                label: const Text(
                  'Download Full Report',
                  style: TextStyle(
                    color: DetectionTheme.textOnDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(
                    color: DetectionTheme.downloadBorder,
                    width: 1.2,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
            Divider(
              color: Colors.white.withValues(alpha: 0.2),
              thickness: 1,
            ),
            const SizedBox(height: 16),

            const Text(
              'Suspicious Segments',
              style: TextStyle(
                color: DetectionTheme.primaryLight,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                gradient: DetectionTheme.suspicionTimelineGradient,
              ),
            ),
            const SizedBox(height: 16),

            SizedBox(
              height: 110,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SegmentThumbnail(
                    timeRange: '0:00-0:30',
                    percent: 58,
                    gradient: DetectionTheme.percentBadgeYellowOrange,
                    imagePath: AppImages.onboarding3,
                  ),
                  const SizedBox(width: 12),
                  SegmentThumbnail(
                    timeRange: '0:45-1:12',
                    percent: 92,
                    gradient: DetectionTheme.percentBadgeRed,
                    imagePath: AppImages.onboarding1,
                  ),
                  const SizedBox(width: 12),
                  SegmentThumbnail(
                    timeRange: '1:30-1:58',
                    percent: 65,
                    gradient: DetectionTheme.percentBadgeGreen,
                    imagePath: AppImages.onboarding2,
                  ),
                ],
              ),
            ),

            SizedBox(height: AppResponsive.hp(context, 10)),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNav(activePage: 'scan',

      ),
    );
  }
}

class _VideoPreview extends StatelessWidget {
  const _VideoPreview({required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppResponsive.hp(context, 28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              imagePath,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: DetectionTheme.surfaceDark,
                child: const Icon(
                  Icons.videocam_off_rounded,
                  color: Colors.white54,
                  size: 48,
                ),
              ),
            ),
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.9),
              ),
              child: const Icon(
                Icons.play_arrow_rounded,
                color: DetectionTheme.backgroundDark,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
