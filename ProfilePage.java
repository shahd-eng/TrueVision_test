import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// تأكدي إن المسارات دي مطابقة لتقسيمة فولدرات TrueVision عندك
import '../../../core/utils/app_colors.dart';
import '../../../domain/entities/user.dart';
import '../../../core/widgets/app_container.dart';
import '../../../core/widgets/app_button.dart';

// الصفحات الفرعية
import 'subscription_plans_page.dart';
import '../pages/edit_profile_page.dart';

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
    // Scaffold هو الحل للشاشة الحمراء لأنه بيوفر الـ Material لكل الـ Widgets اللي تحت
    return Scaffold(
      backgroundColor: const Color(0xFF0E1728), // لون خلفية TrueVision
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
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
                    const SizedBox(height: 100), // مسافة للـ Bottom Nav
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          ),
          Text(
            'Profile',
            style: GoogleFonts.workSans(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 48), 
        ],
      ),
    );
  }

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
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfileScreen()));
                      },
                      child: const Icon(Icons.edit_rounded, size: 18, color: Color(0xFF3D9889)),
                    ),
                  ],
                ),
                const Text('shahd.hany@example.com', style: TextStyle(color: Colors.white70, fontSize: 14)),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Icon(Icons.shield_rounded, color: Color(0xFF16A34A), size: 14),
                    SizedBox(width: 4),
                    Text('Verified Account', style: TextStyle(color: Color(0xFF16A34A), fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _avatarIcon() {
    return Icon(Icons.person_rounded, color: AppColors.lightTextSecondary, size: 64);
  }

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
              const Text('CURRENT PLAN', style: TextStyle(color: Color(0xFFC7D2FE), fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text('Premium Member', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              const Text('Unlimited scans & priority support', style: TextStyle(color: Color(0xFFE0E7FF), fontSize: 14)),
              const SizedBox(height: 16),
              AppButton(
                text: 'View Subscription Plans',
                height: 50,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const SubscriptionPlansScreen()));
                },
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(color: const Color(0xFF3D9889).withOpacity(0.8), shape: BoxShape.circle),
              child: Center(
                child: Image.asset('assets/images/Vector (4).png', width: 26, height: 26, fit: BoxFit.contain),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Your Activity', style: TextStyle(color: Color(0xFF3D9889), fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildActivityCard('assets/images/Vector (5).png', '247', 'Files\nAnalyzed')),
            const SizedBox(width: 12),
            Expanded(child: _buildActivityCard('assets/images/Vector (6).png', '89', 'Reports')),
            const SizedBox(width: 12),
            Expanded(child: _buildActivityCard('assets/images/Vector (7).png', '34', 'Shared')),
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
        border: Border.all(color: const Color(0xFF3D9889).withOpacity(0.5), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF3D9889), Color(0xFF0E1728)]),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(child: Image.asset(imagePath, width: 18, height: 18)),
          ),
          const SizedBox(height: 12),
          Text(value, style: const TextStyle(color: Color(0xFF3D9889), fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildSettingsSection() {
    final items = [
      _TileData(Icons.credit_card_outlined, 'Payment Method'),
      _TileData(Icons.notifications_rounded, 'Enable Notifications', isToggle: true),
      _TileData(Icons.shield_outlined, 'Privacy & Security'),
      _TileData(Icons.settings_outlined, 'Account Settings'),
      _TileData(Icons.logout_rounded, 'Logout', isDestructive: true),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Settings & Actions', style: TextStyle(color: Color(0xFF3D9889), fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        // Material هنا بيحمي الـ ListTile من الشاشة الحمراء
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
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTile(IconData icon, String label, bool? toggleValue, {bool isDestructive = false, bool showDivider = true}) {
    final textColor = isDestructive ? const Color(0xFFEF4444) : Colors.white;
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: textColor),
          title: Text(label, style: TextStyle(color: textColor, fontSize: 15, fontWeight: FontWeight.w500)),
          trailing: toggleValue != null
              ? Switch.adaptive(value: toggleValue, activeColor: const Color(0xFF3D9889), onChanged: (v) => setState(() => _notificationsEnabled = v))
              : Icon(Icons.chevron_right_rounded, color: textColor.withOpacity(0.7)),
        ),
        if (showDivider) const Divider(color: Colors.white12, indent: 16, endIndent: 16),
      ],
    );
  }
}

class _TileData {
  final IconData icon; final String label; final bool isToggle; final bool isDestructive;
  _TileData(this.icon, this.label, {this.isToggle = false, this.isDestructive = false});
}