import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:true_vision/core/responsive/app_responsive.dart';
import 'package:true_vision/features/detection/core/detection_theme.dart';
import 'package:true_vision/features/detection/presentation/pages/media_type_page.dart';
import 'package:true_vision/features/detection/presentation/widgets/detection_app_bar.dart';
import 'package:true_vision/features/detection/presentation/widgets/detection_bottom_nav.dart';

import '../../../../core/theme/app_colors.dart';


/// شاشة History في حالة عدم وجود أي تحليلات بعد.
class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  static const String routeName = '/history';

  void _startAnalysis(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const MediaTypePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // يخلي حتة الساعة شفافة فتاخد لون الـ Scaffold
        statusBarIconBrightness: Brightness.light, // يخلي أيقونات الساعة والشحن بيضاء
        systemNavigationBarColor: AppColors.navy500, // يوحد لون الـ Navigation Bar اللي تحت كمان
    ),
    child: Scaffold(
      backgroundColor: AppColors.navy500,
      appBar: PreferredSize(

        preferredSize: Size.fromHeight(AppResponsive.hp(context, 10)),
        child: Padding(

          padding: EdgeInsets.only(top: AppResponsive.hp(context, 4)),
          child: DetectionAppBar(
            title: 'History',
            onBack: () => Navigator.of(context).pop(),
            trailingIcon:
              Icons.search_rounded,


            onTrailingTap: () {

            },
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: AppResponsive.hp(context, 6)),

            // الأيقونة الكبيرة في المنتصف
            Center(
              child: SizedBox(
                width: 180,
                height: 180,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: DetectionTheme.surfaceDark,
                      ),
                      child: const Icon(
                        Icons.history_rounded,
                        color: DetectionTheme.primaryLight,
                        size: 72,
                      ),
                    ),
                    Positioned(
                      bottom: 18,
                      right: 42,
                      child: Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: DetectionTheme.backgroundDark,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.black.withValues(alpha: 0.35),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: DetectionTheme.primaryLight,
                          ),
                          child: const Icon(
                            Icons.play_circle_fill_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: AppResponsive.hp(context, 3)),

            const Text(
              'No analysis history yet',
              style: TextStyle(
                color: DetectionTheme.primaryLight,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Upload your first file to see analysis results\nhere and track all your deepfake detections.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.75),
                fontSize: 14,
                height: 1.5,
              ),
            ),

            SizedBox(height: AppResponsive.hp(context, 4)),

            // زر Start Analysis
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppResponsive.wp(context, 10)),
              child: GestureDetector(
                onTap: () => _startAnalysis(context),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: DetectionTheme.tealGradient,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Start Analysis',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: AppResponsive.hp(context, 5)),


            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppResponsive.wp(context, 4)),
              child: Row(
                children: const [
                  Expanded(
                    child: _HistoryFeatureCard(
                      icon: Icons.bolt_rounded,
                      title: 'Fast Detection',
                      subtitle: 'Results in seconds',
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _HistoryFeatureCard(
                      icon: Icons.auto_graph_rounded,
                      title: 'High Accuracy',
                      subtitle: 'AI-powered analysis',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(activePage: 'history',


        ),
    ),


    );
  }
}

class _HistoryFeatureCard extends StatelessWidget {
  const _HistoryFeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: DetectionTheme.cardDark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: DetectionTheme.tealGradient,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 22,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.75),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

