import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/trending_item.dart';
import '../../../core/widgets/app_container.dart';
import '../../../core/widgets/app_button.dart';

class ContentAnalysisPage extends StatefulWidget {
  final TrendingItem item;

  const ContentAnalysisPage({super.key, required this.item});

  @override
  State<ContentAnalysisPage> createState() => _ContentAnalysisPageState();
}

class _ContentAnalysisPageState extends State<ContentAnalysisPage> {
  bool _isPlaying = false;

  static const List<String> _defaultFlagReasons = [
    'Facial inconsistencies in lip movement patterns',
    'Unnatural eye blink frequency and timing',
    'Audio-visual synchronization mismatch',
    'Lighting inconsistencies around facial features',
  ];

  @override
  Widget build(BuildContext context) {
    final probability = (widget.item.aiConfidence * 100).clamp(0.0, 100.0);
    final displayPercent = probability > 0 ? probability.round() : 82;

    return Scaffold(
      backgroundColor:AppColors.navy500,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildVideoSection(),
              const SizedBox(height: 16),
              if (widget.item.isAiGenerated) ...[
                _buildAiAlert(displayPercent),
                const SizedBox(height: 20),
              ],
              _buildWhyFlaggedSection(),
              const SizedBox(height: 24),
              _buildDetectedManipulationAreas(),
              const SizedBox(height: 24),
              _buildContentInformation(),
              const SizedBox(height: 24),
              _buildShareAwarenessButton(),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.navy500,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 25),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        'Content Analysis',
        style: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Image.asset(
            'assets/images/Frame.png',
            width: 22,
            height: 22,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }

  Widget _buildVideoSection() {
    return AppContainer(
      padding: 0,
      borderRadius: 12,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  height: 220,
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/images/veo3-pic 1.png',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: AppColors.navy500,
                          child: const Icon(
                            Icons.image_not_supported_outlined,
                            size: 48,
                            color: AppColors.lightTextSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _buildVideoControls(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoControls() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Colors.black.withValues(alpha: 0.8)],
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
              color: Colors.white,
              size: 28,
            ),
            onPressed: () => setState(() => _isPlaying = !_isPlaying),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
          ),
          IconButton(
            icon: const Icon(
              Icons.replay_10_rounded,
              color: Colors.white,
              size: 24,
            ),
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          ),
          IconButton(
            icon: const Icon(
              Icons.forward_10_rounded,
              color: Colors.white,
              size: 24,
            ),
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          ),
          const SizedBox(width: 8),
          Text(
            '00:01 / 00:06',
            style: GoogleFonts.inter(fontSize: 12, color: Colors.white70),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(
              Icons.fullscreen_rounded,
              color: Colors.white,
              size: 24,
            ),
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          ),
        ],
      ),
    );
  }

  Widget _buildAiAlert(int displayPercent) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2).withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFDC2626).withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: const Color(0xFFFEE2E2),
                child: Image.asset(
                  'assets/images/warning.png',
                  width: 14,
                  height: 20,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(width: 4),
              Text(
                'This content is AI-generated',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF7F1D1D),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                'AI Generated Probability',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF991B1B),
                ),
              ),

              const Spacer(),

              Text(
                '$displayPercent%',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF7F1D1D),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: displayPercent / 100,
                    minHeight: 8,
                    backgroundColor: const Color(
                      0xFFFECACA,
                    ).withValues(alpha: 0.5),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFFDC2626),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'High confidence detection of artificial content manipulation',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFFB91C1C),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhyFlaggedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Why This Was Flagged',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF3D9889),
          ),
        ),
        const SizedBox(height: 16),
        ..._defaultFlagReasons.map(
          (reason) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEF4444),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    reason,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFFFFFFF),
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetectedManipulationAreas() {
    const sectionTitleTeal = Color(0xFF3D9889);
    const containerBg = Color(0xFF101B2F);
    final thumbnails = [
      'assets/images/img (7).png',
      'assets/images/img (8).png',
      'assets/images/img (6).png',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Detected Manipulation Areas',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: sectionTitleTeal,
          ),
        ),
        const SizedBox(height: 12),
        AppContainer(
          padding: 12,
          borderRadius: 8,
          child: Row(
            children: List.generate(3, (i) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: i < 2 ? 8 : 0),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            thumbnails[i],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            errorBuilder: (_, __, ___) => Container(
                              color: containerBg,
                              child: const Icon(
                                Icons.image_outlined,
                                color: AppColors.lightTextSecondary,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 6,
                          right: 6,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFFEF4444),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildContentInformation() {
    const sectionTitleTeal = Color(0xFF3D9889);
    const statusOrange = Color(0xFFEA580C);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Content Information',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: sectionTitleTeal,
          ),
        ),
        const SizedBox(height: 16),
        AppContainer(
          padding: 16,
          borderRadius: 12,
          child: Column(
            children: [
              _buildInfoRow(
                label: 'Source Platform',
                valueWidget: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/i.png',
                      width: 20,
                      height: 20,
                      fit: BoxFit.contain,
                    ),

                    const SizedBox(width: 8),
                    Text(
                      'Twitter',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _buildInfoRow(
                label: 'Date Detected',
                valueWidget: Text(
                  'Nov 28, 2024',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _buildInfoRow(
                label: 'Status',
                valueWidget: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: statusOrange,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Trending',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: statusOrange,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow({required String label, required Widget valueWidget}) {
    const labelGrey = Color(0xFFFFFFFF);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: labelGrey,
          ),
        ),
        const Spacer(),
        valueWidget,
      ],
    );
  }

  Widget _buildShareAwarenessButton() {
    return AppButton(
      text: 'Share Awareness',
      height: 52,
      icon: Image.asset(
        'assets/images/Frame.png',
        width: 18,
        height: 18,
        fit: BoxFit.contain,
      ),
      onPressed: () {},
    );
  }
}
