import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class NotificationsSettingsScreen extends StatefulWidget {
  @override
  _NotificationsSettingsScreenState createState() => _NotificationsSettingsScreenState();
}

class _NotificationsSettingsScreenState extends State<NotificationsSettingsScreen> {
  // حالات الـ Switches
  bool pushNotify = true;
  bool scanResultNotify = true;
  bool newsNotify = false;
  bool securityAlerts = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tvDB, // الخلفية الأساسية
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Notifications",
            style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // كارت التحكم الرئيسي
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.buttonV2, AppColors.primary500],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.borderColor)

              ),
              child: Row(
                children: [
                  const Icon(Icons.notifications_active_outlined, size: 40, color: Colors.white),
                  const SizedBox(width: 15),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Push Notifications",
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        Text("Stay updated with real-time alerts",
                            style: TextStyle(color: Colors.white70, fontSize: 12)),
                      ],
                    ),
                  ),
                  Switch(
                    value: pushNotify,
                    onChanged: (val) => setState(() => pushNotify = val),
                    activeColor: Colors.white,
                    activeTrackColor: AppColors.primaryButtonLight,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            const Text("Notification Preferences",
                style: TextStyle(color: AppColors.lightTextSecondary, fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),

            // لستة الخيارات بستايل الـ Figma
            _buildNotifyTile(
              "Scan Results",
              "Get notified when AI analysis is complete",
              scanResultNotify,
                  (val) => setState(() => scanResultNotify = val),
            ),
            _buildNotifyTile(
              "Deepfake News",
              "Latest updates in media manipulation",
              newsNotify,
                  (val) => setState(() => newsNotify = val),
            ),
            _buildNotifyTile(
              "Security Alerts",
              "Privacy and account security warnings",
              securityAlerts,
                  (val) => setState(() => securityAlerts = val),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotifyTile(String title, String subtitle, bool value, Function(bool) onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.lb, // اللون الفرعي للكروت
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderColor.withOpacity(0.1)),
      ),
      child: ListTile(
        title: Text(title, style: const TextStyle(color: AppColors.textPrimary, fontSize: 15, fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: const TextStyle(color: AppColors.lightTextSecondary, fontSize: 12)),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.primary500,
        ),
      ),
    );
  }
}