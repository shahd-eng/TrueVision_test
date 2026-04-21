import 'package:flutter/material.dart';

import '../detection/presentation/widgets/detection_bottom_nav.dart';
import 'RealOrFakeQuizScreen.dart';
import '../../core/widgets/app_button.dart';

class ProtectionTipsScreen extends StatelessWidget {
  const ProtectionTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color scaffoldBgColor = Color(0xFF0E1728);
    const Color primaryGreen = Color(0xFF3D9889);

    return Scaffold(
      bottomNavigationBar:BottomNav(activePage: 'Learn',) ,
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Protection tips",
          style: TextStyle(color: Color(0xFFDCE3EA), fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        children: [
          const SizedBox(height: 20),

          /// 1. الوصف العلوي (RichText)
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              style: TextStyle(color: Colors.white, fontSize: 16, height: 1.4),
              children: [
                TextSpan(text: "Stay safe with these "),
                TextSpan(
                  text: "essential tips ",
                  style: TextStyle(color: primaryGreen, fontWeight: FontWeight.bold),
                ),
                TextSpan(text: "to spot and\n"),
                TextSpan(
                  text: "prevent ",
                  style: TextStyle(color: primaryGreen, fontWeight: FontWeight.bold),
                ),
                TextSpan(text: "deepfakes."),
              ],
            ),
          ),

          const SizedBox(height: 40),

          /// 2. قائمة النصائح (Checklist)
          _buildTipItem("Verify the source."),
          _buildTipItem("Don’t trust viral content."),
          _buildTipItem("use detection tools."),
          _buildTipItem("Report fake media."),
          _buildTipItem("Check the details."),
          _buildTipItem("Look for manipulation."),

          const SizedBox(height: 40),

          /// 3. النص الختامي
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              style: TextStyle(color: Colors.white, fontSize: 15, height: 1.5),
              children: [
                TextSpan(text: "Stay "),
                TextSpan(
                  text: "skeptical ",
                  style: TextStyle(color: primaryGreen, fontWeight: FontWeight.bold),
                ),
                TextSpan(text: "and "),
                TextSpan(
                  text: "informed",
                  style: TextStyle(color: primaryGreen, fontWeight: FontWeight.bold),
                ),
                TextSpan(text: ". always double-\ncheck before believing what you see online."),
              ],
            ),
          ),

          const SizedBox(height: 30),

          /// 4. زر Next
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: AppButton(
              text: 'Next',
              height: 55,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RealOrFakeQuizScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// ويدجت بناء سطر النصيحة (Tip Item)
  Widget _buildTipItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          // أيقونة الـ Checkbox الزرقاء زي الصورة
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF).withOpacity(0.6), // لون أزرق رمادي فاتح
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(width: 15),
          // نص النصيحة
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}