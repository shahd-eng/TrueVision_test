import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:true_vision/core/constants/app_images.dart';
import 'package:true_vision/core/responsive/app_responsive.dart';
import 'package:true_vision/features/detection/core/detection_theme.dart';
import 'package:true_vision/features/detection/core/detection_media_type.dart'; // تأكدي من وجود هذا الـ import
import 'package:true_vision/features/detection/presentation/widgets/detection_app_bar.dart';
import 'package:true_vision/features/detection/presentation/widgets/detection_bottom_nav.dart';
import 'package:true_vision/features/detection/presentation/widgets/segment_thumbnail.dart';
import 'package:true_vision/features/detection/presentation/widgets/video_info_card.dart';

class ScanResultPage extends StatelessWidget {
  const ScanResultPage({
    super.key,
    required this.result,
    required this.file,
    required this.mediaType,
  });

  final Map<String, dynamic> result;
  final File file;
  final DetectionMediaType mediaType;

  @override
  Widget build(BuildContext context) {
    // استخراج البيانات من الـ API
    final String label = result['predicted_label'] ?? 'Unknown';
    final Map<String, dynamic> probabilities = result['probabilities'] ?? {};

    // تحويل النسب من String (86.8%) إلى Double أو Int للعرض
    final String fakePercentStr = probabilities['fake'] ?? '0%';
    final String realPercentStr = probabilities['real'] ?? '0%';

    final int fakeValue = int.tryParse(fakePercentStr.replaceAll('%', '').split('.').first) ?? 0;

    // تحديد الألوان بناءً على النتيجة
    final Color resultColor = label.toLowerCase() == 'fake'
        ? DetectionTheme.cancelRed
        : Colors.greenAccent;

    return Scaffold(
      backgroundColor: DetectionTheme.backgroundDark,
      appBar: PreferredSize(
        // hp(context, 10) مثلاً عشان تدي مساحة كافية للـ AppBar والمسافة اللي فوقه
        preferredSize: Size.fromHeight(AppResponsive.hp(context, 10)),
        child: Padding(
          // هنا بنتحكم في المسافة اللي فوق الـ AppBar بس
          padding: EdgeInsets.only(top: AppResponsive.hp(context, 3)),
          child: DetectionAppBar(
            title: 'Scan Result',
            onBack: () => Navigator.of(context).pop(),
            trailingIcon: Icons.info_outline_rounded,
          ),
        ),
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

            // عرض حالة النتيجة بشكل بارز
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: resultColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: resultColor, width: 1.5),
                ),
                child: Text(
                  label.toUpperCase(),
                  style: TextStyle(
                    color: resultColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),

            SizedBox(height: AppResponsive.hp(context, 3)),

            VideoInfoCard(
              fileName: file.path.split('/').last, // عرض اسم الملف الحقيقي
              scannedAt: 'Today at ${TimeOfDay.now().format(context)}',
              duration: mediaType == DetectionMediaType.image ? 'Image' : 'Media',
              size: 'Result Confirmed',
            ),

            SizedBox(height: AppResponsive.hp(context, 2)),

            // --- الجزء الديناميكي لعرض الميديا بناءً على النوع ---
            _buildMediaPreview(context),

            SizedBox(height: AppResponsive.hp(context, 2.5)),

            // عرض نسب الـ Confidence
            Row(
              children: [
                Expanded(
                  child: _buildConfidenceBox("AI Fake", fakePercentStr, DetectionTheme.cancelRed),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildConfidenceBox("Real Human", realPercentStr, Colors.greenAccent),
                ),
              ],
            ),

            SizedBox(height: AppResponsive.hp(context, 3)),

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
              'Deepfake Probability Details',
              style: TextStyle(
                color: DetectionTheme.primaryLight,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),

            // بار يعرض النسبة الكلية بشكل جرافيك
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: fakeValue / 100,
                minHeight: 12,
                backgroundColor: Colors.greenAccent.withValues(alpha: 0.2),
                valueColor: AlwaysStoppedAnimation<Color>(resultColor),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Suspicious Segments (AI Analysis)',
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
                    timeRange: 'Full Content',
                    percent: fakeValue,
                    gradient: label == 'fake'
                        ? DetectionTheme.percentBadgeRed
                        : DetectionTheme.percentBadgeGreen,
                    imagePath: AppImages.onboarding3,
                  ),
                ],
              ),
            ),

            SizedBox(height: AppResponsive.hp(context, 10)),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNav(activePage: 'scan'),
    );
  }

  // ويدجت ذكي يعرض ميديا بناءً على النوع
  Widget _buildMediaPreview(BuildContext context) {
    if (mediaType == DetectionMediaType.audio) {
      return _AudioPlayerWidget(audioFile: file);
    } else if (mediaType == DetectionMediaType.image) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.file(
          file,
          width: double.infinity,
          height: AppResponsive.hp(context, 28),
          fit: BoxFit.cover,
        ),
      );
    } else {
      // حالة الفيديو (مؤقتاً أيقونة بلاي)
      return Container(
        width: double.infinity,
        height: AppResponsive.hp(context, 28),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(child: Icon(Icons.play_circle_fill, color: Colors.white, size: 64)),
      );
    }
  }

  Widget _buildConfidenceBox(String title, String percent, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: DetectionTheme.cardDark,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 4),
          Text(
            percent,
            style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _AudioPlayerWidget extends StatefulWidget {
  const _AudioPlayerWidget({required this.audioFile});
  final File audioFile;

  @override
  State<_AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

// ضفنا TickerProviderStateMixin عشان الـ Animation
class _AudioPlayerWidgetState extends State<_AudioPlayerWidget> with TickerProviderStateMixin {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  late AnimationController _animationController;


  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // السطر السحري اللي هيخليها تقف لوحدها
    _audioPlayer.onPlayerComplete.listen((event) {
      if (mounted) {
        setState(() {
          isPlaying = false; // يرجع أيقونة الـ Play
          _animationController.stop(); // يوقف حركة الويف
          _animationController.value = 0; // يصفر الويف لمكانه الطبيعي
        });
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          const SizedBox(width: 20),
          GestureDetector(
            onTap: () async {
              if (isPlaying) {
                await _audioPlayer.pause();
                _animationController.stop(); // وقف الحركة
              } else {
                await _audioPlayer.play(DeviceFileSource(widget.audioFile.path));
                _animationController.repeat(reverse: true); // شغل الحركة
              }
              setState(() => isPlaying = !isPlaying);
            },
            child: Icon(
              isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
              size: 56,
              color: DetectionTheme.primaryLight,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Audio Analyzed",
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  "Click to play the sample source",
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12),
                ),
              ],
            ),
          ),

          // --- الويف المتحرك هنا يا شهد ---
          _AnimatedWaveform(isAnimating: isPlaying, controller: _animationController),

          const SizedBox(width: 20),
        ],
      ),
    );
  }
}
class _AnimatedWaveform extends StatelessWidget {
  final bool isAnimating;
  final AnimationController controller;

  const _AnimatedWaveform({required this.isAnimating, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center, // النبض بيطلع من النص لفوق وتحت
          children: List.generate(9, (index) { // زودنا عدد البارات لـ 9 عشان تملا المساحة

            // معادلة الحركة: خليناها Sine Wave عشان النبضة تكون ناعمة وسريعة
            double pulse = isAnimating
                ? (0.3 + 0.7 * (index % 2 == 0 ? controller.value : 1 - controller.value))
                : 0.2;

            // ارتفاعات مختلفة لكل بار عشان شكل "ويف" حقيقي
            final List<double> heights = [20, 35, 25, 45, 55, 45, 25, 35, 20];
            double currentMaxHeight = heights[index];

            return AnimatedContainer(
              duration: const Duration(milliseconds: 50), // تنعيم الحركة جداً
              margin: const EdgeInsets.symmetric(horizontal: 2.5),
              width: 3.5, // عرض البار
              height: currentMaxHeight * pulse,
              decoration: BoxDecoration(
                // لون متوهج لما يشتغل
                color: isAnimating
                    ? DetectionTheme.primaryLight
                    : Colors.white10,
                borderRadius: BorderRadius.circular(10),
                boxShadow: isAnimating ? [
                  BoxShadow(
                    color: DetectionTheme.primaryLight.withValues(alpha: 0.3),
                    blurRadius: 4,
                  )
                ] : [],
              ),
            );
          }),
        );
      },
    );
  }
}