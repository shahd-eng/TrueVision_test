import 'package:flutter/material.dart';

import '../detection/presentation/widgets/detection_bottom_nav.dart';
import 'RisksAndEthicsScreen.dart';
import '../../core/widgets/app_container.dart';
import '../../core/widgets/app_button.dart';

class DetectDeepfakeScreen extends StatelessWidget {
  const DetectDeepfakeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color scaffoldBgColor = Color(0xFF0E1728);

    return Scaffold(
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
          "Detect Deepfake",
          style: TextStyle(color: Color(0xFFDCE3EA), fontWeight: FontWeight.w600),
        ),
      ),


      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 10),

          /// 1. الوصف العلوي
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(color: Colors.white, fontSize: 15, height: 1.4),
                children: [
                  TextSpan(text: "How to spot "),
                  TextSpan(
                    text: "fake media ",
                    style: TextStyle(color: Color(0xFF2F8F84), fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: "using simple clues."),
                ],
              ),
            ),
          ),

          const SizedBox(height: 25),

          /// 2. الصورة الرئيسية
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/image 1.png',
              height: 320,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 40),

          /// 3. شبكة الكروت
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 40,
            childAspectRatio: 1.1,
            clipBehavior: Clip.none,
            children: [
              _buildClueCard("1", "Unnatural Eyes", "Unusual blinking or eye movement.", scaffoldBgColor),
              _buildClueCard("2", "Lip Sync issues", "Lips don’t match the words.", scaffoldBgColor),
              _buildClueCard("3", "Light & Shadow", "Inconsistent lighting on face.", scaffoldBgColor),
              _buildClueCard("4", "Audio mismatch", "Voice sounds robotic or fake.", scaffoldBgColor),
            ],
          ),

          const SizedBox(height: 20),

          /// 4. النص التوضيحي الجديد (تمت إضافته هنا)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "If something feels “off”, it’s worth\ndouble checking the source.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFB8C4D0),
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),

          const SizedBox(height: 25),

          /// 5. زر التالي (Next)
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: AppButton(
              text: 'Next',
              height: 55,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RisksAndEthicsScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar:BottomNav(activePage: 'Learn',) ,
    );
  }

  Widget _buildClueCard(String number, String title, String desc, Color bgColor) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        /// الكارت
        AppContainer(
          padding: 0,
          borderRadius: 16,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 25, 12, 12),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                desc,
                style: const TextStyle(color: Colors.white70, fontSize: 12, height: 1.3),
              ),
            ],
          ),
        ),
      ),

        /// تأثير الفتحة (Cut Effect)
        Positioned(
          top: -22,
          left: -22,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(shape: BoxShape.circle, color: bgColor),
          ),
        ),

        /// الدائرة (البروز الأكبر)
        Positioned(
          top: -15,
          left: -15,
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(colors: [Color(0xFF3D9889), Color(0xFF0B1324)]),
              border: Border.all(color: bgColor, width: 2.5),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF45C4A1).withOpacity(0.35),
                  blurRadius: 10,
                  spreadRadius: 2,
                )
              ],
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
          ),
        ),
      ],
    );
  }
}