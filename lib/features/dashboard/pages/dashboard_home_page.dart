import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/app_colors.dart';
import '../cubit/dashboard_cubit.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/recent_detections_section.dart';
import '../widgets/trending_card.dart';
import '../widgets/trending_section.dart';

// Import لملف الـ Injection بتاعك (تأكدي من صحة المسار)
import '../../../injection.dart';

/// Home tab body (nested under [MainShell] bottom navigation).
class DashboardHomePage extends StatefulWidget {
  const DashboardHomePage({super.key});

  @override
  State<DashboardHomePage> createState() => _DashboardHomePageState();
}

class _DashboardHomePageState extends State<DashboardHomePage> {
  @override
  Widget build(BuildContext context) {
    // الحل النهائي: نغلف بـ BlocProvider ونستخدم كلاس الـ Injection بتاعك
    return BlocProvider(
      // بنادي على الميثود اللي بتعمل 'الطبخة' وتجهز الكوبيت بالـ Repository والـ DataSource
      create: (context) => Injection.createDashboardCubit()..loadDashboard(),
      child: Scaffold(
        backgroundColor: AppColors.primaryBackgroundDarkColor,
        body: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            // التعامل مع الـ Status بناءً على الـ Cubit بتاعك
            return switch (state.status) {
              DashboardStatus.initial => const SizedBox.shrink(),
              DashboardStatus.loading => const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF3D9889), // لون التيال بتاع ترو فيجن
                ),
              ),
              DashboardStatus.error => _buildErrorWidget(context, state.errorMessage),
              DashboardStatus.loaded => _buildContent(state),
            };
          },
        ),
      ),
    );
  }

  // ويدجت لعرض الخطأ وزرار المحاولة مرة أخرى
  Widget _buildErrorWidget(BuildContext context, String? message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 48),
          const SizedBox(height: 16),
          Text(
            message ?? 'Something went wrong',
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3D9889),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () => context.read<DashboardCubit>().loadDashboard(),
            child: const Text('Retry', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(DashboardState state) {
    // تأمين البيانات عشان ما يحصلش Null Error لو الداتا لسه ما وصلتش كاملة
    if (state.user == null) {
      return const Center(child: Text('User data not available', style: TextStyle(color: Colors.white)));
    }

    final user = state.user!;
    final trendingItem = state.trendingItem;
    final recentDetections = state.recentDetections;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(), // سكرول ناعم
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          DashboardHeader(user: user),
          const SizedBox(height: 28),
          const TrendingSection(),
          const SizedBox(height: 16),
          if (trendingItem != null) ...[
            TrendingCard(item: trendingItem),
            const SizedBox(height: 24),
          ],
          RecentDetectionsSection(items: recentDetections),
          const SizedBox(height: 120), // مسافة أمان للـ Nav Bar
        ],
      ),
    );
  }
}