import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  // دالة لفتح الإيميل
  Future<void> _sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@truevision.ai',
      queryParameters: {
        'subject': '[TRUEVISION Support Request] - Sama Wesam',
        'body': 'Hello TRUEVISION Team, \n\n I need help with...'
      },
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    }
  }

  // دالة لفتح الواتساب (لو حابة تضيفيها كميزة إضافية)
  Future<void> _openWhatsApp() async {
    var whatsappUrl = "whatsapp://send?phone=+201234567890&text=Hello TRUEVISION Support";
    final Uri whatsappUri = Uri.parse(whatsappUrl);
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tvDB,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Contact Us",
            style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const SizedBox(height: 30),

            // الهيدر بالأيقونة
            _buildContactIllustration(),

            const SizedBox(height: 30),
            const Text(
              "How can we help you?",
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Our support team is here to help you with any technical issues or inquiries about TRUEVISION.",
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.lightTextSecondary, fontSize: 14),
            ),

            const SizedBox(height: 40),

            // كارت الإيميل
            _buildContactMethod(
              icon: Icons.email_outlined,
              title: "Email Support",
              subtitle: "support@truevision.ai",
              onTap: _sendEmail, // ربط الدالة هنا
            ),

            // كارت واتساب (اختياري بس بيدي شكل حلو)
            _buildContactMethod(
              icon: Icons.chat_bubble_outline_rounded,
              title: "WhatsApp Chat",
              subtitle: "Average response: 10 mins",
              onTap: _openWhatsApp, // ربط الدالة هنا
            ),

            _buildContactMethod(
              icon: Icons.language_rounded,
              title: "Visit Website",
              subtitle: "www.truevision.ai",
              onTap: () async {
                final Uri url = Uri.parse('https://www.truevision.ai');
                if (await canLaunchUrl(url)) await launchUrl(url);
              },
            ),

            const SizedBox(height: 50),
            const Text(
              "Version 1.0.0",
              style: TextStyle(color: Colors.white24, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactIllustration() {
    return Container(
      height: 140,
      width: 140,
      decoration: BoxDecoration(
        color: AppColors.primary500.withOpacity(0.05),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.support_agent_rounded, size: 70, color: AppColors.primary500),
    );
  }

  Widget _buildContactMethod({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: AppColors.lb,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.tvDB,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.primary500),
        ),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(color: AppColors.lightTextSecondary, fontSize: 12)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 14),
      ),
    );
  }
}