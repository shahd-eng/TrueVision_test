import 'package:flutter/material.dart';

import 'HowItsMadeScreen.dart';
import '../../core/widgets/app_button.dart';

class TypesOfDeepfakeScreen extends StatefulWidget {
  const TypesOfDeepfakeScreen({super.key});

  @override
  State<TypesOfDeepfakeScreen> createState() => _TypesOfDeepfakeScreenState();
}

class _TypesOfDeepfakeScreenState extends State<TypesOfDeepfakeScreen> {
  // متغير عشان نعرف أنهي Tab مختارينه حالياً
  String selectedType = "Video";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E1728),
      /// 1. Header (بدون Gradient المرة دي حسب الصورة)
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Types of Deepfake",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 16),

            /// 2. Intro Text
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(color: Colors.white, fontSize: 16),
                children: [
                  TextSpan(text: "There are three main types of deepfakes:\n"),
                  TextSpan(text: "Videos, Audio, ", style: TextStyle(color: Color(0xFF3D9889), fontWeight: FontWeight.bold)),
                  TextSpan(text: "and ", style: TextStyle(color: Colors.white)),
                  TextSpan(text: "image.", style: TextStyle(color: Color(0xFF3D9889), fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            const SizedBox(height: 25),

            /// 3. Custom Tab Bar (Video, Audio, Image)
            Row(
              children: [
                _buildTabButton("Video"),
                const SizedBox(width: 10),
                _buildTabButton("Audio"),
                const SizedBox(width: 10),
                _buildTabButton("Image"),
              ],
            ),

            const SizedBox(height: 25),

            /// 4. Main Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/image 10.png',
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 25),

            /// 5. Description List (تتغير حسب الـ Tab)
            _buildDescriptionList(),

            const SizedBox(height: 30),

            /// 6. Warning Note
            const Divider(color: Color(0xFF37887D), ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Deepfakes can be creative, but misuse\ncan cause serious harm.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 14, height: 1.4),
              ),
            ),
            const SizedBox(height: 20),
            AppButton(
              text: 'Next',
              height: 55,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HowItsMadeScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),

      /// 7. Bottom Navigation Bar
      // bottomNavigationBar: _buildBottomNav(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: const Color(0xFF1B323D),
      //   child: const Icon(Icons.document_scanner_outlined, color: Color(0xFF41BC72)),
      // ),
    );
  }

  // Widget لبناء الأزرار اللي فوق (Tabs)
  Widget _buildTabButton(String label) {
    bool isSelected = selectedType == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedType = label),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF37887D) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFF37887D)),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? const Color(0xFFFFFFFF) : Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildDescriptionList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBulletPoint("1- A person's face is swapped in a video", "to make them say or do things they didn't."),
        const SizedBox(height: 15),
        _buildBulletPoint("2- Lip sync issues", "the lips are out of sync with the spoken words."),
        const SizedBox(height: 15),
        _buildBulletPoint("3- Voice cloning", "Imitating someone's voice to generate fake audio."),
      ],
    );
  }

  Widget _buildBulletPoint(String title, String sub) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Color(0xFF3D9889), fontWeight: FontWeight.bold, fontSize: 15)),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 4),
          child: Text(sub, style: const TextStyle(color: Colors.white, fontSize: 14)),
        ),
      ],
    );
  }
}