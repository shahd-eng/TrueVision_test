import 'package:flutter/material.dart';
import 'package:true_vision/core/constants/app_images.dart';
import 'package:true_vision/core/responsive/app_responsive.dart';
import 'package:true_vision/core/theme/app_colors.dart';
import 'package:true_vision/core/widgets/primary_button.dart';
import 'package:true_vision/features/detection/presentation/pages/media_type_page.dart';
import 'package:true_vision/features/detection/presentation/widgets/detection_app_bar.dart';

import '../../../protection/presentation/pages/protection_page.dart';

class ChooseFunctionPage extends StatefulWidget {
  const ChooseFunctionPage({super.key});

  static const String routeName = '/choose-function';

  @override
  State<ChooseFunctionPage> createState() => _ChooseFunctionPageState();
}

class _ChooseFunctionPageState extends State<ChooseFunctionPage> {

  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy500,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppResponsive.hp(context, 10)),
        child: Padding(
          padding: EdgeInsets.only(top: AppResponsive.hp(context, 4)),
          child: DetectionAppBar(
            title: 'Choose Function',
            onBack: () => Navigator.of(context).pop(),
            trailingIcon: Icons.info_outline_rounded,
            onTrailingTap: () {},
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    SizedBox(height: AppResponsive.hp(context, 2)),

                    // Header Section
                    const Text(
                      'Welcome to',
                      style: TextStyle(color: AppColors.primary500, fontSize: 14),
                    ),
                    const SizedBox(height: 11),
                    Image.asset(
                      AppImages.logo2,
                      width: AppResponsive.wp(context, 30),
                      height: AppResponsive.hp(context, 6),
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Select whether you want to detect AI\nmanipulation or protect your content.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 14, height: 1.5),
                    ),
                    const SizedBox(height: 40),

                    // Function Cards Row
                    Row(
                      children: [
                        Expanded(
                          child: _FunctionCard(
                            title: 'Detection',
                            icon: Icons.search,
                            imagePath: AppImages.detection,
                            isSelected: _selectedIndex == 0,
                            onTap: () => setState(() => _selectedIndex = 0),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _FunctionCard(
                            title: 'Protection',
                            icon: Icons.shield,
                            imagePath: AppImages.protection,
                            isSelected: _selectedIndex == 1,
                            onTap: () => setState(() => _selectedIndex = 1),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // How it works box
                    _buildHowItWorksBox(),
                  ],
                ),
              ),
            ),

            // Divider
            Divider(color: Colors.black.withValues(alpha: 0.7), thickness: 3, height: 1),

            // Continue Button
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: PrimaryButton(
                label: 'Continue',
                backgroundColor: _selectedIndex != null ? AppColors.primary500 : Colors.transparent,
                isOutlined: _selectedIndex == null,
                  // جوه ChooseFunctionPage عند الزرار
                  onPressed: () {
                    if (_selectedIndex == 0) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const MediaTypePage(),
                        ),

                      );
                    }
                    else{ Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ProtectionPage(),
                      ),

                    );}
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHowItWorksBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF121F36).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary500.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb, color: AppColors.primary500, size: 20),
              const SizedBox(width: 8),
              const Text(
                'How it works',
                style: TextStyle(color: Color(0xFF3BA291), fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Detection identifies AI alterations in your media.\nProtection helps safeguard your original content from future manipulation.',
            style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.5),
          ),
        ],
      ),
    );
  }
}
class _FunctionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const _FunctionCard({
    required this.title,
    required this.icon,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 210,
        width: 160,
        decoration: BoxDecoration(
          color: isSelected ? null :AppColors.lb,
          gradient: isSelected
              ? const LinearGradient(
            colors: [
              AppColors.buttonV2,
              AppColors.navy500,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops:  [0.1, 0.8],
          )
              : null,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF3BA291) : Colors.white10,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // المربع اللي جوه اللي فيه الصورة
            Container(
              width: 126,
              height: 128,
              decoration: BoxDecoration(
                color: Color(0xFF06B6D4).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white10),
              ),
              child: Center(
                child: Image.asset(imagePath, width: 96,), // استبدلي بأيقوناتك
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: AppColors.buttonV2, size: 18),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}