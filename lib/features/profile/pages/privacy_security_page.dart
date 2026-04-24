import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../auth/presentation/pages/reset_password_page.dart';

class PrivacySecurityScreen extends StatefulWidget {
  @override
  _PrivacySecurityScreenState createState() => _PrivacySecurityScreenState();
}

class _PrivacySecurityScreenState extends State<PrivacySecurityScreen> {
  bool isTwoStepVerif = true;
  bool faceIdEnabled = true;

  // 1. طلعنا الدالة بره الـ build ونظمنا الـ context بتاعها
  void _showClearHistoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.lb,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.redAccent),
            SizedBox(width: 10),
            Text("Clear History?", style: TextStyle(color: Colors.white, fontSize: 18)),
          ],
        ),
        content: const Text(
          "This action will permanently delete all your previous deepfake analysis reports. This cannot be undone.",
          style: TextStyle(color: AppColors.lightTextSecondary, fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              // هنا كود المسح الفعلي
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("History cleared successfully")),
              );
            },
            child: const Text("Delete", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tvDB,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Privacy & Security",
          style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _buildSecurityHeader(),
            const SizedBox(height: 30),
            const Text(
              "Login & Recovery",
              style: TextStyle(color: AppColors.lightTextSecondary, fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            _buildSecurityTile(
              icon: Icons.lock_outline,
              title: "Change Password",
              trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white24),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ResetPasswordPage(
                    email: 'sama@gmail.com',
                  )),
                );
              },
            ),
            _buildSecurityTile(
              icon: Icons.phonelink_lock,
              title: "Two-step Verification",
              trailing: Switch.adaptive(
                value: isTwoStepVerif,
                onChanged: (val) => setState(() => isTwoStepVerif = val),
                activeColor: AppColors.primary500,
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              "Biometrics",
              style: TextStyle(color: AppColors.lightTextSecondary, fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            _buildSecurityTile(
              icon: Icons.face_unlock_outlined,
              title: "Face ID / Fingerprint",
              trailing: Switch.adaptive(
                value: faceIdEnabled,
                onChanged: (val) => setState(() => faceIdEnabled = val),
                activeColor: AppColors.primary500,
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              "Data Privacy",
              style: TextStyle(color: AppColors.lightTextSecondary, fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            _buildSecurityTile(
              icon: Icons.delete_outline,
              title: "Clear Analysis History",
              trailing: const Icon(Icons.delete_sweep, color: Colors.redAccent, size: 22),
              onTap: () => _showClearHistoryDialog(context), // 2. نادينا الدالة هنا بشكل سليم
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.lb,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary500.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.shield_outlined, size: 50, color: AppColors.primary500),
          const SizedBox(width: 20),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Security Status", style: TextStyle(color: Colors.white70, fontSize: 12)),
                SizedBox(height: 4),
                Text(
                  "YOUR DATA IS SAFE",
                  style: TextStyle(color: AppColors.primaryButtonLight, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSecurityTile({required IconData icon, required String title, required Widget trailing, VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.lb,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: AppColors.tvDB2),
        title: Text(title, style: const TextStyle(color: AppColors.textPrimary, fontSize: 15)),
        trailing: trailing,
      ),
    );
  }
}