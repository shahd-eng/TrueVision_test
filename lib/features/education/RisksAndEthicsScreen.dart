import 'package:flutter/material.dart';

import '../detection/presentation/widgets/detection_bottom_nav.dart';
import 'ProtectionTipsScreen.dart';
import '../../core/widgets/app_container.dart';
import '../../core/widgets/app_button.dart';

class RisksAndEthicsScreen extends StatelessWidget {
  const RisksAndEthicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color scaffoldBgColor = Color(0xFF0E1728);

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
          "Risks & Ethics",
          style: TextStyle(color: Color(0xFFDCE3EA), fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 10),

          /// 1. الوصف العلوي (RichText)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(color: Colors.white, fontSize: 16, height: 1.4),
                children: [
                  TextSpan(text: "Understanding the "),
                  TextSpan(
                    text: "dangers ",
                    style: TextStyle(color: Color(0xFF2F8F84), fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: "and "),
                  TextSpan(
                    text: "ethical concerns ",
                    style: TextStyle(color: Color(0xFF2F8F84), fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: "of deepfake technology."),
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),

          /// 2. عنوان القسم (Risks)
          const Text(
            "Risks:",
            style: TextStyle(
              color: Color(0xFF2F8F84),
              fontSize: 22,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              decorationColor: Color(0xFF2F8F84),
            ),
          ),

          const SizedBox(height: 20),

          /// 3. شبكة كروت الـ Risks
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 0.82,
            children: [
              _buildRiskCard("Reputation damage", "Fake media can damage someone’s reputation.", "assets/images/image 3.png"),
              _buildRiskCard("Identity theft", "Deepfakes can be used to steal personal information.", "assets/images/image 4.png"),
              _buildRiskCard("Misinformation", "Fake stories or news can deceive the public.", "assets/images/image 5.png"),
              _buildRiskCard("Privacy violations", "Private videos or photos can be misused.", "assets/images/image 6.png"),
            ],
          ),

          const SizedBox(height: 30),

          /// 4. عنوان القسم (Ethics)
          const Text(
            "Ethics:",
            style: TextStyle(
              color: Color(0xFF2F8F84),
              fontSize: 22,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              decorationColor: Color(0xFF2F8F84),
            ),
          ),

          const SizedBox(height: 20),

          /// 5. شبكة كروت الـ Ethics (الجزء الجديد)
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 0.82,
            children: [
              _buildRiskCard(
                "Consent",
                "Using someone’s face or voice without permission is unethical.",
                "assets/images/image 7.png",
              ),
              _buildRiskCard(
                "Responsibility",
                "Technology should be used responsibly, not harmfully.",
                "assets/images/image 8.png",
              ),
            ],
          ),

          const SizedBox(height: 35),

          /// 6. النص الختامي (Ethics Quote)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Deepfake is a powerful technology. using\nit ethically is a responsibility, not a choice.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                height: 1.4,
              ),
            ),
          ),

          const SizedBox(height: 25),

          /// 7. زر التالي (Next)
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: AppButton(
              text: 'Next',
              height: 55,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProtectionTipsScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// نفس الـ Function اللي بتبني الكروت استخدمناها للاثنين
  Widget _buildRiskCard(String title, String desc, String imagePath) {
    return AppContainer(
      padding: 0,
      borderRadius: 20,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(19),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Image.asset(
                imagePath,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.white10,
                  child: const Icon(Icons.image, color: Colors.white24),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF2F8F83), Color(0xFF0B1324)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13, // صغرت الخط سنة عشان العناوين الطويلة
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      desc,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}