import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';
import '../../../domain/entities/trending_item.dart';
import '../../content_analysis/pages/content_analysis_page.dart';
import '../../../core/widgets/app_container.dart';
import '../../../core/widgets/app_button.dart';

class TrendingCard extends StatelessWidget {
  final TrendingItem item;
  static const double cardRadius = 24;

  const TrendingCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      padding: 0,
      borderRadius: cardRadius,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(cardRadius),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildImageSection(), _buildContentSection(context)],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            item.imagePath,
            fit: BoxFit.fill,
            errorBuilder: (_, __, ___) => Container(
              color: AppColors.authCardBackground,
              child: Icon(
                Icons.image_not_supported_outlined,
                size: 64,
                color: AppColors.lightTextSecondary,
              ),
            ),
          ),
          if (item.isAiGenerated) _buildAiBadge(),
        ],
      ),
    );
  }

  Widget _buildAiBadge() {
    return Positioned(
      top: 12,
      right: 12,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFEF4444),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.smart_toy, color: Colors.white, size: 16),
            const SizedBox(width: 6),
            Text(
              'AI Generated',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            item.description,
            style: GoogleFonts.inter(
              fontSize: 14,
              height: 1.5,
              fontWeight: FontWeight.w400,
              color: const Color(0xFFFFFFFF),
            ),
          ),
          const SizedBox(height: 10),
          _buildStatsRow(context),
        ],
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.visibility_outlined,
                  size: 16,
                  color: const Color(0xFFFFFFFF),
                ),
                const SizedBox(width: 4),
                Text(
                  item.views,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: const Color(0xFFFFFFFF),
                  ),
                ),
                const SizedBox(width: 12),
                Icon(
                  Icons.share_outlined,
                  size: 16,
                  color: const Color(0xFFFFFFFF),
                ),
                const SizedBox(width: 4),
                Text(
                  item.shares,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: const Color(0xFFFFFFFF),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 113,
          child: AppButton(
            text: 'View Analysis',
            height: 32,
            borderRadius: 8,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ContentAnalysisPage(item: item),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
