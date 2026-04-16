import 'package:flutter/material.dart';

import 'DetectDeepfakeScreen.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_container.dart';

class HowItsMadeScreen extends StatelessWidget {
  const HowItsMadeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E1728),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "How it’s made",
          style: TextStyle(
            color: Color(0xFFDCE3EA),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        // أضفت مسافة جانبية أكبر قليلاً للسماح ببروز الدوائر دون الخروج من الشاشة
        padding: const EdgeInsets.fromLTRB(25, 10, 20, 10),
        children: [
          const SizedBox(height: 10),

          /// 1. الوصف العلوي
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 15,
                  height: 1.4,
                ),
                children: [
                  TextSpan(text: "AI learns from faces and voices, then\n"),
                  TextSpan(
                    text: "generates fake media ",
                    style: TextStyle(
                      color: Color(0xFF3D9889),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: "step-by-step."),
                ],
              ),
            ),
          ),

          const SizedBox(height: 45), // مساحة أكبر قبل بدء الخطوات

          /// 2. قائمة الخطوات
          _buildStep("1", "Collect data",
              "AI is fed with many photos, videos, and audio clips of a person."),
          _buildStep("2", "Train the AI",
              "The AI learns the person’s face, voice, and expressions."),
          _buildStep("3", "Fake media generation",
              "The AI creates new, realistic images, videos, or audio."),
          _buildStep("4", "Refine & Edit",
              "Final touches are made to make it look and sound convincing."),

          const SizedBox(height: 15),

          /// 3. نص التنبيه
          const Text(
            "For awareness only\n(no technical details)",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 30),

          /// 4. زر التالي
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: AppButton(
              text: 'Next',
              height: 55,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DetectDeepfakeScreen(),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStep(String number, String title, String desc) {
    return Padding(
      // زيادة المسافة السفلية واليسرى لضمان بروز الدائرة
      padding: const EdgeInsets.only(bottom: 35, left: 5),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          /// الكارت (Container)
          AppContainer(
            padding: 0,
            borderRadius: 16,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 25, 20, 20),
              child: Padding(
              // إزاحة النص للداخل لتجنب التداخل مع الدائرة البارزة
              padding: const EdgeInsets.only(left: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    desc,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

          /// تأثير الفتحة خلف الدائرة (Cut Effect)
          Positioned(
            top: -22, // سحب لبروز أكثر للأعلى
            left: -22, // سحب لبروز أكثر لليسار
            child: Container(
              width: 62,
              height: 62,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF0E1728), // نفس لون الخلفية
              ),
            ),
          ),

          /// دائرة الرقم البارزة
          Positioned(
            top: -15,
            left: -15,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF3D9889),
                    Color(0xFF0B1324),
                  ],
                ),
                border: Border.all(
                  color: const Color(0xFF0E1728),
                  width: 2.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF3D9889).withOpacity(0.4),
                    blurRadius: 12,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Center(
                child: Text(
                  number,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}