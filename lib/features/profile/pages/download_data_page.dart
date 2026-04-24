import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class DownloadDataScreen extends StatelessWidget {
  const DownloadDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tvDB, // اللون الكحلي الغامق
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Export Data",
          style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60),

            // --- الأيقونة المركزية (نفس شكل الصورة) ---
            _buildCentralIcon(),

            const SizedBox(height: 40),
            const Text(
              "Your Analysis Report",
              style: TextStyle(color: AppColors.textPrimary, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              "Download a comprehensive report of all your deepfake detection history and forensic results.",
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.lightTextSecondary, fontSize: 14, height: 1.5),
            ),

            const SizedBox(height: 40),

            // --- كارت الإحصائيات المستطيل (نفس الصورة) ---
            _buildStatsCard(),

            const Spacer(),

            // --- زرار الـ Gradient المربوط بالـ Bottom Sheet ---
            _buildGradientButton(context),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildCentralIcon() {
    return Container(
      height: 140,
      width: 140,
      decoration: BoxDecoration(
        color: AppColors.primary500.withOpacity(0.05),
        shape: BoxShape.circle,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.cloud_outlined, size: 100, color: AppColors.primary500.withOpacity(0.15)),
          const Icon(Icons.file_download_outlined, size: 45, color: AppColors.primary500),
        ],
      ),
    );
  }

  Widget _buildStatsCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.lb, // اللون الأزرق الأفتح شوية
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem("125", "Images"),
          _buildStatItem("42", "Videos"),
          _buildStatItem("18", "Audios"),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: AppColors.primary500, fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 13)),
      ],
    );
  }

  Widget _buildGradientButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [AppColors.tvDB2, AppColors.primary500],
        ),
        boxShadow: [
          BoxShadow(color: AppColors.primary500.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 6))
        ],
      ),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: () => _showExportSuccess(context), // هنا الربط السليم
        icon: const Icon(Icons.file_present_rounded, color: Colors.white),
        label: const Text("Request Data Export",
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  // --- دالة الـ Bottom Sheet المفصولة لضمان العمل ---
  void _showExportSuccess(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.lb,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(30),
          height: 380,
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Icon(Icons.check_circle_rounded, color: AppColors.primaryButtonLight, size: 85),
              const SizedBox(height: 25),
              const Text(
                "Report Generated!",
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                "Your forensic analysis report is ready for download. You can find it in your downloads folder.",
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.lightTextSecondary, fontSize: 15, height: 1.4),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary500,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Download PDF",
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}