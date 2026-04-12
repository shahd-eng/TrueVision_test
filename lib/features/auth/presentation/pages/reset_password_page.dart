import 'package:flutter/material.dart';
import 'package:true_vision/core/constants/app_images.dart';
import 'package:true_vision/core/responsive/app_responsive.dart';
import 'package:true_vision/core/theme/app_colors.dart';
import 'package:true_vision/core/widgets/app_text_field.dart';
import 'package:true_vision/core/widgets/primary_button.dart';
import 'package:true_vision/features/auth/presentation/pages/reset_success_page.dart';
import 'package:true_vision/features/auth/presentation/widgets/auth_background.dart';
import '../../data/auth_api_service.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({
    super.key,
    required this.email,
  });

  static const String routeName = '/reset-password';

  final String email;

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final AuthApiService _authApiService = AuthApiService();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleResetPassword() async {
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter and confirm the new password')),
      );
      return;
    }

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authApiService.resetPassword(
        email: widget.email,
        password: newPassword,
        confirmPassword: confirmPassword,
      );

      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (_) => const ResetSuccessPage(),
        ),
      );
    } on AuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message)),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong. Please try again.'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

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
                SizedBox(height: AppResponsive.hp(context, 6)),
                // Back Button
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: AppResponsive.wp(context, 1)),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.textPrimary,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
                SizedBox(height: AppResponsive.hp(context, 2)),
                // Logo
                Image.asset(
                  AppImages.logo2,
                  width: AppResponsive.wp(context, 40),
                  height: AppResponsive.wp(context, 20),
                  fit: BoxFit.contain,
                ),
                SizedBox(height: AppResponsive.hp(context, 2)),
                // Title
                Text(
                  'Reset password',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppResponsive.hp(context, 2)),
                // Form
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppResponsive.wp(context, 1)),
                  child: Column(
                    children: [

                      // New Password
                      AppTextField(
                        hint: 'Enter new password',
                        obscureText: true,
                        controller: _newPasswordController,
                      ),

                      SizedBox(height: AppResponsive.hp(context, 2)),
                      // Confirm Password
                      AppTextField(
                        hint: 'Confirm new password',
                        obscureText: true,
                        controller: _confirmPasswordController,
                      ),

                      SizedBox(height: AppResponsive.hp(context, 4)),
                      PrimaryButton(
                        label: _isLoading ? 'Processing...' : 'Confirm',
                        onPressed: _isLoading
                            ? null
                            : () {
                                _handleResetPassword();
                              },
                      ),
                      SizedBox(height: AppResponsive.hp(context, 2)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    required this.label,
    required this.hint,
    required this.obscureText,
    required this.onToggleVisibility,
  });

  final String label;
  final String hint;
  final bool obscureText;
  final VoidCallback onToggleVisibility;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.textPrimary.withValues(alpha: 0.8),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: obscureText,
          style: const TextStyle(color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: AppColors.textPrimary.withValues(alpha: 0.4),
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                color: AppColors.textPrimary.withValues(alpha: 0.6),
              ),
              onPressed: onToggleVisibility,
            ),
          ),
        ),
      ],
    );
  }
}
