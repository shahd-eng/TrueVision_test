import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../detection/presentation/widgets/detection_bottom_nav.dart';
import '../shell/main_shell.dart';
import 'DetectDeepfakeScreen.dart';
import 'HowItsMadeScreen.dart';
import 'ProtectionTipsScreen.dart';
import 'RealOrFakeQuizScreen.dart';
import 'RisksAndEthicsScreen.dart';
import 'TypesOfDeepfakeScreen.dart';
import 'what_is_deepfake.dart';

class EducationHomeScreen extends StatelessWidget {
  const EducationHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final List<Map<String, String>> modules = [
      {
        'title': 'What is Deepfake?',
        'progress': '00%',
        'icon': 'assets/images/deepfake 1.png'
      },
      {
        'title': 'Types of Deepfake',
        'progress': '00%',
        'icon': 'assets/images/layer 1.png'
      },
      {
        'title': 'How it\'s made',
        'progress': '00%',
        'icon': 'assets/images/psychology 1.png'
      },
      {
        'title': 'Detect Deepfake',
        'progress': '00%',
        'icon': 'assets/images/eye-recognition 1.png'
      },
      {
        'title': 'Risks & Ethics',
        'progress': '00%',
        'icon': 'assets/images/stability 1.png'
      },
      {
        'title': 'Protect yourself',
        'progress': '00%',
        'icon': 'assets/images/shield 1.png'
      },
      {
        'title': 'Real or Fake ?',
        'progress': '00%',
        'icon': 'assets/images/check 1.png'
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0E1728),

      body: Column(
        children: [

          /// HEADER
          Container(
            padding: const EdgeInsets.only(
              top: 60,
              bottom: 30,
              left: 20,
              right: 20,
            ),

            width: double.infinity,

            decoration: const BoxDecoration(
              color: AppColors.navy500,
            ),

            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Color(0xFFFFFFFF),
                    size: 28,
                  ),
                  onPressed: () {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    } else {
                      MainShellScope.selectTabOf(context, 0);
                    }
                  },
                ),

                Expanded(
                  child: Text(
                    "Understanding Deepfake",
                    textAlign: TextAlign.center,

                    style: const TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(width: 8),
              ],
            ),
          ),

          /// MAIN PROGRESS
          Padding(
            padding: const EdgeInsets.all(30.0),

            child: Column(
              children: [

                ClipRRect(
                  borderRadius: BorderRadius.circular(10),

                  child: const LinearProgressIndicator(
                    value: 0.05,
                    minHeight: 8,

                    backgroundColor: Colors.white,

                    valueColor:
                    const AlwaysStoppedAnimation<Color>(
                        Color(0xFF3D9889)),
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  "Progress: 00%",
                  style: TextStyle(
                    color: Color(0xFF3D9889),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          /// MODULES
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),

              itemCount: modules.length,

              itemBuilder: (context, index) {
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => openEducationModule(context, index),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF101B2F),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                        child: Row(
                        children: [
                          Image.asset(
                            modules[index]['icon']!,
                            width: 30,
                            height: 30,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  modules[index]['title']!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10),
                                        child: const LinearProgressIndicator(
                                          value: 0.0,
                                          minHeight: 4,
                                          backgroundColor: const Color(0xFF1E293B),
                                          valueColor:
                                              const AlwaysStoppedAnimation<Color>(
                                            Color(0xFF3D9889),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      modules[index]['progress']!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
}

void openEducationModule(BuildContext context, int index) {
  final Widget screen = switch (index) {
    0 => const WhatIsDeepfakeScreen(),
    1 => const TypesOfDeepfakeScreen(),
    2 => const HowItsMadeScreen(),
    3 => const DetectDeepfakeScreen(),
    4 => const RisksAndEthicsScreen(),
    5 => const ProtectionTipsScreen(),
    6 => const RealOrFakeQuizScreen(),
    _ => const SizedBox.shrink(),
  };
  Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => screen),
  );
}