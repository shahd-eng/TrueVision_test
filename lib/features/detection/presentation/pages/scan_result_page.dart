import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:true_vision/core/constants/app_images.dart';
import 'package:true_vision/core/responsive/app_responsive.dart';
import 'package:true_vision/features/detection/core/detection_theme.dart';
import 'package:true_vision/features/detection/core/detection_media_type.dart';
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
    // 1. استخراج البيانات بذكاء
    final Map<String, dynamic> data = result['result'] ?? result;

    // 3. قراءة الليبل
    final String label = (data['label'] ?? data['predicted_label'] ?? 'Unknown').toString();

    // --- دالة سحرية لتنظيف الأرقام من علامة % وتحويلها لـ double ---
    double parseValue(dynamic val) {
      if (val == null) return 0.0;
      // بنشيل علامة % لو موجودة ونحول النص لرقم
      String cleanVal = val.toString().replaceAll('%', '').trim();
      return double.tryParse(cleanVal) ?? 0.0;
    }

    // 4. استخراج النسب (بندور في المستوى العادي أو جوه 'probabilities')
    final Map<String, dynamic> probs = data['probabilities'] ?? {};

    double realValueRaw = parseValue(data['real_prob'] ?? data['real_probability'] ?? probs['real']);
    double fakeValueRaw = parseValue(data['fake_prob'] ?? data['fake_probability'] ?? probs['fake']);

    // 5. التصحيح الأوتوماتيكي
    // لو الرقم جاي 86.8 (زي الصوت) أو 0.868 (زي الصور)
    if (realValueRaw > 1.0) realValueRaw /= 100;
    if (fakeValueRaw > 1.0) fakeValueRaw /= 100;

    // 6. التنسيق النهائي للعرض
    final String realPercentStr = "${(realValueRaw * 100).toStringAsFixed(1)}%";
    final String fakePercentStr = "${(fakeValueRaw * 100).toStringAsFixed(1)}%";
    final int fakeValue = (fakeValueRaw * 100).toInt();

    final Color resultColor = label.toLowerCase().contains('fake')
        ? DetectionTheme.cancelRed
        : Colors.greenAccent;

    return Scaffold(
      backgroundColor: DetectionTheme.backgroundDark,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppResponsive.hp(context, 10)),
        child: Padding(
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
        padding: EdgeInsets.symmetric(horizontal: AppResponsive.wp(context, 4)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppResponsive.hp(context, 3)),

            // عرض حالة النتيجة
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
                  style: TextStyle(color: resultColor, fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                ),
              ),
            ),

            SizedBox(height: AppResponsive.hp(context, 3)),

            VideoInfoCard(

              fileName: file.path.split('/').last,
              scannedAt: 'Today at ${TimeOfDay.now().format(context)}',

              duration: mediaType == DetectionMediaType.image
                  ? 'Type: Static Image'
                  : 'Type: Audio Stream',
              size: 'Size: ${(file.lengthSync() / (1024 * 1024)).toStringAsFixed(2)} MB',
              mediaType: mediaType,

            ),

            SizedBox(height: AppResponsive.hp(context, 2)),


            _buildMediaPreview(context),

            SizedBox(height: AppResponsive.hp(context, 2.5)),

            // عرض نسب الـ Confidence
            Row(
              children: [
                Expanded(child: _buildConfidenceBox("AI Fake", fakePercentStr, DetectionTheme.cancelRed)),
                const SizedBox(width: 12),
                Expanded(child: _buildConfidenceBox("Real Human", realPercentStr, Colors.greenAccent)),
              ],
            ),

            SizedBox(height: AppResponsive.hp(context, 3)),

            // أزرار التحميل والمشاركة
            _buildActionButtons(),

            const SizedBox(height: 24),
            Divider(color: Colors.white.withValues(alpha: 0.2), thickness: 1),
            const SizedBox(height: 16),


// صف بيعرض الليبل والنسبة فوق بعض بشكل شيك
            const Text(
              'Deepfake Probability Details',
              style: TextStyle(
                color: DetectionTheme.primaryLight,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(

                  mediaType == DetectionMediaType.image
                      ? 'Image Manipulation Analysis'
                      : 'Voice Synthesis Analysis',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 13,
                  ),
                ),
                Text(
                  '$fakeValue%',
                  style: TextStyle(
                    color: resultColor, // اللون أحمر لو فيك، أخضر لو ريل
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),


            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: fakeValue / 100,
                minHeight: 10,
                backgroundColor: Colors.greenAccent.withValues(alpha: 0.1),
                valueColor: AlwaysStoppedAnimation<Color>(resultColor),
              ),
            ),

            const SizedBox(height: 6),

// إضافة نص توضيحي صغير تحت البار (اختياري بس بيدي شكل صايع)
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                label.toUpperCase(),
                style: TextStyle(
                  color: resultColor.withValues(alpha: 0.6),
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.2,
                ),
              ),
            ),

            SizedBox(height: AppResponsive.hp(context, 10)),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNav(activePage: 'scan'),
    );
  }


  Widget _buildMediaPreview(BuildContext context) {
    if (mediaType == DetectionMediaType.audio) {
      // هينادي كود الصوت بتاعك القديم زي ما هو بدون تغيير حرف
      return _AudioPlayerWidget(audioFile: file);
    } else {
      // عرض الصورة بشكل شيك مع برواز بسيط
      // الطريقة الصح:
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.black26, // حطي اللون هنا في الـ Container
          border: Border.all(color: Colors.white10, width: 1.2),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.file(
            file,
            width: double.infinity,
            height: AppResponsive.hp(context, 30),
            fit: BoxFit.contain,

          ),
        ),
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
          Text(percent, style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.download_rounded, size: 20, color: DetectionTheme.textOnDark),
            label: const Text('Download Full Report', style: TextStyle(color: DetectionTheme.textOnDark, fontWeight: FontWeight.w600)),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              side: const BorderSide(color: DetectionTheme.downloadBorder, width: 1.2),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
          ),
        ),
      ],
    );
  }
}


class _AudioPlayerWidget extends StatefulWidget {
  const _AudioPlayerWidget({required this.audioFile});
  final File audioFile;
  @override
  State<_AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<_AudioPlayerWidget> with TickerProviderStateMixin {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _audioPlayer.onPlayerComplete.listen((_) {
      if (mounted) {
        setState(() {
          isPlaying = false;
          _animationController.stop();
          _animationController.value = 0;
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
      decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white10)),
      child: Row(
        children: [
          const SizedBox(width: 20),
          GestureDetector(
            onTap: () async {
              if (isPlaying) {
                await _audioPlayer.pause();
                _animationController.stop();
              } else {
                await _audioPlayer.play(DeviceFileSource(widget.audioFile.path));
                _animationController.repeat(reverse: true);
              }
              setState(() => isPlaying = !isPlaying);
            },
            child: Icon(isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled, size: 56, color: DetectionTheme.primaryLight),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Audio Analyzed", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("Click to play sample", style: TextStyle(color: Colors.white60, fontSize: 12)),
              ],
            ),
          ),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(9, (index) {
            double pulse = isAnimating ? (0.3 + 0.7 * (index % 2 == 0 ? controller.value : 1 - controller.value)) : 0.2;
            final List<double> heights = [20, 35, 25, 45, 55, 45, 25, 35, 20];
            return AnimatedContainer(
              duration: const Duration(milliseconds: 50),
              margin: const EdgeInsets.symmetric(horizontal: 2.5),
              width: 3.5,
              height: heights[index] * pulse,
              decoration: BoxDecoration(
                color: isAnimating ? DetectionTheme.primaryLight : Colors.white10,
                borderRadius: BorderRadius.circular(10),
              ),
            );
          }),
        );
      },
    );
  }
}