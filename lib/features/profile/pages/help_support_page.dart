import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import 'contact-us_page.dart';

class HelpSupportScreen extends StatefulWidget {
  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tvDB, // اللون الكحلي الغامق
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Help & Support",
          style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- حقل البحث عن المساعدة ---
            _buildSearchHeader(),

            const SizedBox(height: 30),
            const Text(
              "Frequently Asked Questions",
              style: TextStyle(
                  color: AppColors.lightTextSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 15),

            // --- قائمة الأسئلة الشائعة (بمعلومات عامة) ---
            _buildFAQTile(
                "How does the detection process work?",
                "Our system uses advanced AI algorithms to analyze digital media files and identify potential manipulation patterns or inconsistencies in the data."
            ),
            _buildFAQTile(
                "Is my personal data secure?",
                "Yes, TRUEVISION prioritizes user privacy. All uploaded files are processed through a secure environment and are handled according to our strict data protection policies."
            ),
            _buildFAQTile(
                "What should I do if a scan fails?",
                "Ensure your internet connection is stable and the file format is supported. If the problem persists, please reach out to our support team."
            ),
            _buildFAQTile(
                "Can I use the app for free?",
                "The app offers a basic tier for analysis. However, you can upgrade to a premium plan for higher limits and more detailed forensic insights."
            ),

            const SizedBox(height: 40),

            // --- كارت التواصل مع الدعم ---
            _buildContactCard(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchHeader() {
    return TextField(
      style: const TextStyle(color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: "Search for help...",
        hintStyle: const TextStyle(color: AppColors.lightTextSecondary),
        prefixIcon: const Icon(Icons.search, color: AppColors.primary500),
        filled: true,
        fillColor: AppColors.lb, // اللون الأزرق الفرعي
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
      ),
    );
  }

  Widget _buildFAQTile(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.lb,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: ExpansionTile(
        iconColor: AppColors.primary500,
        collapsedIconColor: AppColors.lightTextSecondary,
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        title: Text(
            question,
            style: const TextStyle(color: AppColors.textPrimary, fontSize: 14, fontWeight: FontWeight.w500)
        ),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Text(
              answer,
              style: const TextStyle(color: AppColors.lightTextSecondary, fontSize: 13, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.lb,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary500.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: AppColors.tvDB2,
            radius: 22,
            child: Icon(Icons.headset_mic, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 15),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Still need help?",
                    style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)
                ),
                Text(
                    "Our team is available 24/7",
                    style: TextStyle(color: AppColors.lightTextSecondary, fontSize: 12)
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary500,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 15),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContactUsScreen()),
              );
            },
            child: const Text(
                "Contact Us",
                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)
            ),
          ),
        ],
      ),
    );
  }
}