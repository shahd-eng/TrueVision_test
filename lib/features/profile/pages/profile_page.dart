import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/responsive/app_responsive.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/user.dart';
import '../../auth/presentation/pages/sign_up_page.dart';
import '../../detection/presentation/widgets/detection_app_bar.dart';
import '../../../core/widgets/app_container.dart';
import '../../../core/widgets/app_button.dart';
import '../pages/subscription_plans_page.dart';
import '../pages/edit_profile_page.dart';
import 'payment_method_page.dart';
import 'notifications-settings_page.dart';
import 'help_support_page.dart';
import 'privacy_security_page.dart';
import 'download_data_page.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.navy500,
      ),
      child: Scaffold(
        backgroundColor: AppColors.navy500,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppResponsive.hp(context, 10)),
          child: Padding(
            padding: EdgeInsets.only(top: AppResponsive.hp(context, 3)),
            child: DetectionAppBar(
              title: 'Profile',
              onBack: () => Navigator.of(context).pop(),
              trailingIcon: Icons.info_outline_rounded,
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      _buildUserCard(),
                      const SizedBox(height: 24),
                      _buildPlanCard(),
                      const SizedBox(height: 24),
                      _buildActivitySection(),
                      const SizedBox(height: 24),
                      _buildSettingsSection(),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Widgets البناء الأساسية ---

  Widget _buildUserCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF101B2F),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF3D9889).withOpacity(0.5), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: widget.user.avatarPath != null
                    ? ClipOval(
                  child: Image.asset(
                    widget.user.avatarPath!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _avatarIcon(),
                  ),
                )
                    : _avatarIcon(),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: const Color(0xFF22C55E),
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFF101B2F), width: 2),
                  ),
                  child: const Icon(Icons.check_rounded, color: Colors.white, size: 14),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.user.name,
                      style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfileScreen())),
                      child: const Icon(Icons.edit_rounded, size: 18, color: Color(0xFF3D9889)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text('sama.wesam@example.com', style: TextStyle(color: Colors.white, fontSize: 14)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.shield_rounded, color: Color(0xFF16A34A), size: 14),
                    const SizedBox(width: 4),
                    Text('Verified Account', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFF16A34A))),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _avatarIcon() => const Icon(Icons.person_rounded, color: Color(0xFF6F7D7D), size: 64);

  Widget _buildPlanCard() {
    return AppContainer(
      padding: 20,
      borderRadius: 16,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('CURRENT PLAN', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFFC7D2FE))),
              const SizedBox(height: 4),
              Text('Premium Member', style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white)),
              const SizedBox(height: 12),
              const Text('Unlimited scans & priority support', style: TextStyle(color: Color(0xFFE0E7FF), fontSize: 14)),
              const SizedBox(height: 16),
              AppButton(
                text: 'View Subscription Plans',
                height: 50,
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SubscriptionPlansScreen())),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Your Activity', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF3D9889))),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildActivityCard('assets/images/Vector (5).png', '247', 'Files\nAnalyzed')),
            const SizedBox(width: 12),
            Expanded(child: _buildActivityCard('assets/images/Vector (6).png', '89', 'Reports\nGenerated')),
            const SizedBox(width: 12),
            Expanded(child: _buildActivityCard('assets/images/Vector (7).png', '34', 'Files\nShared')),
          ],
        ),
      ],
    );
  }

  Widget _buildActivityCard(String imagePath, String value, String label) {
    return Container(
      height: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF101B2F),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF3D9889).withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(color: const Color(0xFF3D9889), borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.analytics, color: Colors.white, size: 18),
          ),
          const SizedBox(height: 12),
          Text(value, style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w700, color: const Color(0xFF3D9889))),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 11, color: Colors.white)),
        ],
      ),
    );
  }

  // --- سكشن الإعدادات المحدث ---

  Widget _buildSettingsSection() {
    final items = [
      _TileData(Icons.credit_card_outlined, 'Payment Method'),
      _TileData(Icons.notifications_rounded, 'Enable Notifications', isToggle: true),
      _TileData(Icons.shield_outlined, 'Privacy & Security'),
      _TileData(Icons.settings_outlined, 'Account Settings'),
      _TileData(Icons.cloud_download_rounded, 'Download My Data'),
      _TileData(Icons.help_outline_rounded, 'Help & Support'),
      _TileData(Icons.logout_rounded, 'Logout', isDestructive: true),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Settings & Actions', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF3D9889))),
        const SizedBox(height: 16),
        Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF101B2F),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF3D9889).withOpacity(0.5)),
            ),
            child: Column(
              children: items.asMap().entries.map((entry) {
                return _buildSettingsTile(
                  entry.value.icon,
                  entry.value.label,
                  entry.value.isToggle ? _notificationsEnabled : null,
                  isDestructive: entry.value.isDestructive,
                  showDivider: entry.key != items.length - 1,
                  onTap: () => _handleNavigation(entry.value.label),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTile(IconData icon, String label, bool? toggleValue, {bool isDestructive = false, bool showDivider = true, required VoidCallback onTap}) {
    final textColor = isDestructive ? const Color(0xFFEF4444) : Colors.white;

    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(colors: [const Color(0xFF3D9889).withOpacity(0.8), const Color(0xFF0F172A)]),
            ),
            child: Icon(icon, color: textColor, size: 20),
          ),
          title: Text(label, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w500, color: textColor)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (toggleValue != null)
                Switch.adaptive(
                  value: toggleValue,
                  activeColor: const Color(0xFF3D9889),
                  onChanged: (v) => setState(() => _notificationsEnabled = v),
                ),
              const SizedBox(width: 8),
              Icon(Icons.chevron_right_rounded, color: textColor.withOpacity(0.7)),
            ],
          ),
        ),
        if (showDivider) const Divider(height: 1, color: Colors.white12, indent: 16, endIndent: 16),
      ],
    );
  }

  // --- منطق التنقل ---

  void _handleNavigation(String label) {
    Widget? nextScreen;
    switch (label) {
      case 'Payment Method': nextScreen = PaymentMethodScreen(); break;
      case 'Enable Notifications': nextScreen = NotificationsSettingsScreen(); break;
      case 'Privacy & Security': nextScreen = PrivacySecurityScreen(); break;
      case 'Account Settings': nextScreen = EditProfileScreen(); break;
      case 'Download My Data': nextScreen = DownloadDataScreen(); break;
      case 'Help & Support': nextScreen = HelpSupportScreen(); break;
      case 'Logout': _showLogoutDialog(); return;
    }
    if (nextScreen != null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => nextScreen!));
    }
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF101B2F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Logout", style: TextStyle(color: Colors.white)),
        content: const Text("Are you sure you want to log out?",
            style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFEF4444)),
            onPressed: () {

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const SignUpPage()),
                    (route) => false,
              );
            },
            child: const Text("Logout", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class _TileData {
  final IconData icon;
  final String label;
  final bool isToggle;
  final bool isDestructive;
  _TileData(this.icon, this.label, {this.isToggle = false, this.isDestructive = false});
}