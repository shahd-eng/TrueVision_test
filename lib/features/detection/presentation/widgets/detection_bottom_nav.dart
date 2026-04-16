import 'package:flutter/material.dart';
import 'package:true_vision/core/constants/app_images.dart';
import 'package:true_vision/features/detection/core/detection_theme.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../domain/entities/user.dart';
import '../../../dashboard/pages/dashboard_home_page.dart';
import '../../../education/education_mode_home.dart';
import '../../../profile/pages/profile_page.dart';
import '../pages/choose_function_page.dart';
import '../pages/history_page.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({
    super.key,
    required this.activePage, // بنبعت اسم الصفحة كـ String عشان نغير اللون
  });

  final String activePage; // هتبعتي هنا "history" أو "scan" أو "home"

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 65,
            decoration: BoxDecoration(
              color: DetectionTheme.backgroundDark,
              border: Border(
                top: BorderSide(
                  color: Colors.white.withValues(alpha: 0.08),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.home_rounded,
                  label: 'Home',
                  isSelected: activePage == 'home',
    onTap: () {
    if (activePage != 'Home') {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const DashboardHomePage()),
    );
    }}
                ),
                _NavItem(
                  icon: Icons.school_rounded,
                  label: 'Learn',
                  isSelected: activePage == 'learn',
                  onTap: () {
                    if (activePage != 'learn') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const EducationHomeScreen()),
                      );
                    }
                  },
                ),
                const SizedBox(width: 60),
                _NavItem(
                  icon: Icons.history_rounded,
                  label: 'History',
                  isSelected: activePage == 'history',
                  onTap: () {
                    // لو إنتي مش في صفحة الهيستوري، روحي لها
                    if (activePage != 'history') {
                       Navigator.push(context, MaterialPageRoute(builder: (context) => const HistoryPage()));
                    }
                  },
                ),
                _NavItem(
                  icon: Icons.person_rounded,
                  label: 'Profile',
                  isSelected: activePage == 'profile',
                  onTap: () {
                    if (activePage != 'profile') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilePage(
                            user: User(
                              name: "Shahd Hany", // حطي اسمك يا ليدر
                              avatarPath: null, // أو لو عندك صورة في الـ assets
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),

          // زرار الـ Scan
          Positioned(
            bottom: 20,
            child: GestureDetector(
              onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => const ChooseFunctionPage()));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [AppColors.buttonV2, AppColors.navy500],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border.all(
                        color: DetectionTheme.backgroundDark,
                        width: 4,
                      ),
                    ),
                    child: Center(
                      child: Image.asset(AppImages.scan, width: 24, height: 24),
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Scan',
                    style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected ? AppColors.primary500 : Colors.white.withValues(alpha: 0.6),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: isSelected ? AppColors.primary500 : Colors.white.withValues(alpha: 0.6),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}