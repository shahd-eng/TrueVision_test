import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:true_vision/core/constants/app_images.dart';
import 'package:true_vision/core/responsive/app_responsive.dart';
import 'package:true_vision/core/theme/app_colors.dart';
import 'package:true_vision/core/widgets/primary_button.dart';
import 'package:true_vision/features/auth/presentation/pages/sign_in_page.dart';
import 'package:true_vision/features/auth/presentation/widgets/auth_background.dart';

class ResetSuccessPage extends StatelessWidget {
  const ResetSuccessPage({super.key});

  static const String routeName = '/reset-success';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: AppResponsive.hp(context, 20)),
                // Success Icon
                SizedBox(
                  height: AppResponsive.hp(context, 20),
                  child: Image.asset(
                    AppImages.successBadge,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: AppResponsive.hp(context, 4)),
                // Title
                Text(
                  'Successful!',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppResponsive.hp(context, 2)),
                // Message
                Text(
                  'Congratulation! your password changed successfully',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textPrimary.withValues(alpha: 0.8),
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppResponsive.hp(context, 6)),
                PrimaryButton(
                  label: 'Sign-in',
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute<void>(
                        builder: (_) => const SignInPage(),
                      ),
                          (route) => false,
                    );
                  },
                ),

                // Sign In Button

                SizedBox(height: AppResponsive.hp(context, 2)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
