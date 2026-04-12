import 'package:flutter/material.dart';
import 'package:true_vision/core/constants/app_images.dart';
import 'package:true_vision/core/responsive/app_responsive.dart';
import 'package:true_vision/core/theme/app_colors.dart';
import 'package:true_vision/core/widgets/primary_button.dart';
import 'package:true_vision/features/auth/presentation/pages/reset_password_page.dart';
import 'package:true_vision/features/auth/presentation/pages/sign_in_page.dart';
import 'package:true_vision/features/auth/presentation/widgets/auth_background.dart';
import '../../data/auth_api_service.dart';

class VerificationCodePage extends StatefulWidget {
  const VerificationCodePage({
    super.key,
    required this.email,
    required this.isForRegistration,
  });

  final String email;
  final bool isForRegistration;

  static const String routeName = '/verification-code';

  @override
  State<VerificationCodePage> createState() => _VerificationCodePageState();
}

class _VerificationCodePageState extends State<VerificationCodePage> {
  final List<TextEditingController> _controllers =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  final AuthApiService _authApiService = AuthApiService();
  bool _isSubmitting = false;
  bool _hasError = false; // متغير حالة الخطأ للتحكم في لون المربعات

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onCodeChanged(int index, String value) {
    // إعادة تعيين حالة الخطأ بمجرد أن يبدأ المستخدم في الكتابة
    if (_hasError) {
      setState(() => _hasError = false);
    }

    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
  }

  String _collectOtp() {
    return _controllers.map((c) => c.text.trim()).join();
  }

  Future<void> _handleConfirm() async {
    final otp = _collectOtp();

    if (otp.length != 6) {
      setState(() => _hasError = true); // تفعيل اللون الأحمر
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter the 6-digit code'),
          backgroundColor: Colors.red, // سناك بار أحمر
        ),
      );
      return;
    }

    if (widget.isForRegistration) {
      if (_isSubmitting) return;
      setState(() {
        _isSubmitting = true;
        _hasError = false;
      });

      try {
        await _authApiService.validateOtp(
          email: widget.email,
          otpCode: otp,
        );

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email verified successfully. You can now sign in.'),
            backgroundColor: AppColors.primary500,
          ),
        );

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute<void>(
            builder: (_) => const SignInPage(),
          ),
              (route) => false,
        );
      } on AuthException catch (e) {
        if (!mounted) return;
        setState(() => _hasError = true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message),
            backgroundColor: Colors.red,
          ),
        );
      } catch (_) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        if (mounted) {
          setState(() => _isSubmitting = false);
        }
      }
    } else {
      // For password reset flow
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => ResetPasswordPage(email: widget.email),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AuthBackground(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: AppResponsive.hp(context, 6)),

                // Back Button مع تحريكه لليسار باستخدام Transform
                Transform.translate(
                  offset: const Offset(-15, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 32,
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
                  'Verification code',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppResponsive.hp(context, 1.5)),
                // Subtitle
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Please enter security code received on your email',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: AppResponsive.hp(context, 4.5)),

                // OTP Fields
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppResponsive.wp(context, 1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      6,
                          (index) => SizedBox(
                        width: 50,
                        height: 50,
                        child: TextField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            counterText: '',
                            filled: true,
                            fillColor: Colors.transparent,
                            contentPadding: EdgeInsets.zero,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                // يتغير اللون للأحمر في حالة وجود خطأ
                                color: _hasError
                                    ? Colors.red
                                    : Colors.white.withValues(alpha: 0.5),
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: _hasError
                                    ? Colors.red
                                    : AppColors.primaryButtonLight,
                                width: 2,
                              ),
                            ),
                          ),
                          onChanged: (value) => _onCodeChanged(index, value),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: AppResponsive.hp(context, 5)),
                // Confirm Button
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppResponsive.wp(context, 1)),
                  child: PrimaryButton(
                    label: _isSubmitting ? 'Please wait...' : 'Confirm',
                    onPressed: _isSubmitting ? null : _handleConfirm,
                  ),
                ),

                SizedBox(height: AppResponsive.hp(context, 3)),
                // Resend Link
                Column(
                  children: [
                    Text(
                      "Didn't receive a code? ",
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 5),
                    GestureDetector(
                      onTap: () {
                        // Logic لإعادة الإرسال
                      },
                      child: const Text(
                        'Send again',
                        style: TextStyle(
                          color: AppColors.primary500,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppResponsive.hp(context, 4)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}