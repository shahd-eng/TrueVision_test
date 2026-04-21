import 'package:flutter/material.dart';

import '../detection/presentation/widgets/detection_bottom_nav.dart';
import 'TypesOfDeepfakeScreen.dart';
import '../../core/widgets/app_container.dart';
import '../../core/widgets/app_button.dart';

class WhatIsDeepfakeScreen extends StatelessWidget {
  const WhatIsDeepfakeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:BottomNav(activePage: 'Learn',) ,
      backgroundColor: const Color(0xFF0E1728),
      body: Column(
        children: [
          /// 1. Header
          Container(
            padding: const EdgeInsets.only(
              top: 60,
              bottom: 20,
              left: 20,
              right: 20,
            ),
            width: double.infinity,
            decoration: const BoxDecoration(color: Color(0xFF0E1728)),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0xFFFFFFFF)),
                  onPressed: () => Navigator.pop(context),
                ),
                const Expanded(
                  child: Text(
                    "What is Deepfake",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 48), // لموازنة السهم
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  /// 2. Main Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/image 11.png',
                      width: double.infinity,
                      height: 340,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// 3. Definition Box
                  AppContainer(
                    padding: 16,
                    borderRadius: 15,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 16,
                          height: 1.5,
                        ),
                        children: [
                          TextSpan(
                            text: "Deepfake ",
                            style: TextStyle(
                              color: Color(0xFFDC2626),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(text: "is media created using "),
                          TextSpan(
                            text: "artificial intelligence ",
                            style: TextStyle(color: Color(0xFF3D9889)),
                          ),
                          TextSpan(
                            text:
                                "to manipulate images, videos, or voices to appear ",
                          ),
                          TextSpan(
                            text: "real ",
                            style: TextStyle(color: Color(0xFF3D9889)),
                          ),
                          TextSpan(text: "- even when they are "),
                          TextSpan(
                            text: "not.",
                            style: TextStyle(color: Color(0xFF3D9889)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// 4. Features Grid (Cards)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildFeatureCard(
                        "Image Deepfake",
                        "Manipulated or\ngenerated photos",
                        "assets/images/div.png",
                      ),
                      _buildFeatureCard(
                        "Audio Deepfake",
                        "Fake voices that mimic\nreal people",
                        "assets/images/div (1).png",
                      ),
                      _buildFeatureCard(
                        "Video Deepfake",
                        "Fake videos that\nlook real",
                        "assets/images/div (2).png",
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  /// 5. Footer Text
                  const Text(
                    "Not all AI-generated media is harmful\n- context matters",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 14),
                  ),
                  const SizedBox(height: 20),

                  AppButton(
                    text: 'Next',
                    height: 55,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TypesOfDeepfakeScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper widget
  Widget _buildFeatureCard(String title, String desc, String imagePath) {
    return SizedBox(
      width: 112,
      height: 150,
      child: AppContainer(
        padding: 5,
        borderRadius: 15,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 70,
              height: 64,
              fit: BoxFit.contain,
              // حل مشكلة لو الصورة محملتش عشان ميبوظش التصميم
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image, color: Colors.white24, size: 40),
            ),
            const SizedBox(height: 10),

            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF3D9889),
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 5),

            Text(
              desc,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Color(0xFFFFFFFF), fontSize: 9),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
