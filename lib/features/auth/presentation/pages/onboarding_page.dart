import 'package:flutter/material.dart';
import 'package:true_vision/core/constants/app_images.dart';
import 'package:true_vision/core/widgets/primary_button.dart';
import 'package:true_vision/features/auth/presentation/pages/sign_up_page.dart';

import '../../../../core/theme/app_colors.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "title": "Detect beyond your media",
      "sub": "Detecting manipulated audio,\nimages, and videos",
      "image": AppImages.onboarding1,
      "button": "Next",
    },
    {
      "title": "Protect your media\nKeep it authentic",
      "sub": "Detecting manipulated audio,\nimages, and videos", // حسب الصورة
      "image": AppImages.onboarding2,
      "button": "Continue",
    },
    {
      "title": "View Deepfake Trends",
      "sub": "Tracking the latest deepfake patterns and activities\n\"Trust What You See. Verify What You Hear\"",
      "image": AppImages.onboarding3,
      "button": "Get started",
    },
  ];

  void _onNextPressed() {
    if (_currentPage < _onboardingData.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const SignUpPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tvDB, // لون الـ Background الغامق من الصورة
      body: SafeArea(
        child: Column(
          children: [
            // Skip Button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextButton(
                  onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const SignUpPage()),
                  ),
                  child: const Text(
                    'Skip',
                    style: TextStyle(color: AppColors.shadowColor, fontSize: 10),
                  ),
                ),
              ),
            ),

            // PageView Content
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) {
                  return _OnboardingContentItem(
                    title: _onboardingData[index]["title"]!,
                    sub: _onboardingData[index]["sub"]!,
                    image: _onboardingData[index]["image"]!,
                  );
                },
              ),
            ),

            // Dots Indicator
            _DotsIndicator(activeIndex: _currentPage, count: _onboardingData.length),

            const SizedBox(height: 16),

            // Action Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: PrimaryButton(
                label: _onboardingData[_currentPage]["button"]!,
                onPressed: _onNextPressed,

              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class _OnboardingContentItem extends StatelessWidget {
  final String title, sub, image;

  const _OnboardingContentItem({
    required this.title,
    required this.sub,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double screenHeight = size.height;
    final double screenWidth = size.width;

    return Column(
      children: [
        // استخدام Spacer عشان الصورة تتوسط المساحة المتاحة فوق النص


        Container(
          // العرض: 85% من عرض الشاشة
          width: screenWidth * 0.80,
          // الارتفاع: 40% من طول الشاشة (بدل 350 الثابتة)
          height: screenHeight * 0.45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: AssetImage(image),
              // BoxFit.contain بيحافظ على أبعاد الصورة الأصلية جوه المساحة
              fit: BoxFit.fill,
            ),
          ),
        ),

        // مسافة متناسبة مع طول الشاشة
        SizedBox(height: screenHeight * 0.03),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          child: Column(
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primary500,
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                sub,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.038,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: screenHeight * 0.02),
      ],
    );
  }
}

class _DotsIndicator extends StatelessWidget {
  final int activeIndex;
  final int count;

  const _DotsIndicator({required this.activeIndex, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        bool isActive = index == activeIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: isActive ? 8 : 8,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF3BA291) : Colors.grey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}