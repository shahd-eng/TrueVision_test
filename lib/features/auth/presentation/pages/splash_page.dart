import 'package:flutter/material.dart';
import 'package:true_vision/core/constants/app_images.dart';
import 'package:true_vision/core/responsive/app_responsive.dart';
import 'package:true_vision/features/auth/presentation/pages/onboarding_page.dart';
import 'package:true_vision/features/auth/presentation/widgets/auth_background.dart';

import '../../../../core/theme/app_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const String routeName = '/splash';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 8), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const OnboardingPage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;

              var tween = Tween(begin: begin, end: end).chain(
                CurveTween(curve: curve),
              );

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 600),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double logoSize = AppResponsive.wp(context, 26);

    return Scaffold(
      body: AuthBackground(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: logoSize,
                height: logoSize,
                padding: const EdgeInsets.all(12),
                child: Image.asset(
                  AppImages.logo,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16), 
              Text(
                'TrueVision',
                style: TextStyle(
                  fontSize: 30,
                  color: AppColors.primary500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



