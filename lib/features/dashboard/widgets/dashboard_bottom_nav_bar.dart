import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';

class DashboardBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final VoidCallback onScanTap;

  const DashboardBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
    required this.onScanTap,
  });

  static const double navBarHeight = 96;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return SizedBox(
      height: navBarHeight + bottomPadding,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          _buildNavBar(bottomPadding),
          Positioned(top: -32, child: _buildFabFrame()),
        ],
      ),
    );
  }

  Widget _buildNavBar(double bottomPadding) {
    return Container(
      width: double.infinity,
      height: navBarHeight + bottomPadding,
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 12,
        bottom: bottomPadding + 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.authCardBackground,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, Icons.home_rounded, 'Home'),
          _buildNavItem(1, Icons.school_rounded, 'Learn'),
          const SizedBox(width: 80),
          _buildNavItem(3, Icons.history_rounded, 'History'),
          _buildNavItem(4, Icons.person_rounded, 'Profile'),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = selectedIndex == index;
    final color = isSelected ? Color(0xFF3D9889) : Colors.white;

    return GestureDetector(
      onTap: () => onTabSelected(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 26, color: color),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFabFrame() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.authCardBackground,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white24, width: 2),
      ),
      child: Center(child: _buildScanFab()),
    );
  }

  Widget _buildScanFab() {
    return GestureDetector(
      onTap: onScanTap,
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF3D9889), Color(0xFF0E1728)],
          ),
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF0E1728), width: 4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: const Center(
        child: Image(
        image: AssetImage("Assets/images/scan.png"),
        width: 40,
        height: 40,
        fit: BoxFit.contain,
      ),
    ),


      ),
    );
  }
}
