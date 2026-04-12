import 'package:flutter/material.dart';
import 'package:true_vision/core/constants/app_images.dart';
import 'package:true_vision/core/responsive/app_responsive.dart';
import 'package:true_vision/core/theme/app_colors.dart';
import 'package:true_vision/core/widgets/app_text_field.dart';
import 'package:true_vision/core/widgets/primary_button.dart';
import 'package:true_vision/features/auth/presentation/pages/verification_code_page.dart';
import 'package:true_vision/features/auth/presentation/widgets/auth_background.dart';
import '../../data/auth_api_service.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  static const String routeName = '/forgot-password';

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  final AuthApiService _authApiService = AuthApiService();
  bool _isLoading = false;
  String? _emailError; // متغير لتخزين رسالة الخطأ أو تغيير حالة البوردر

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    final email = _emailController.text.trim();

    // تشيك على الايميل
    if (email.isEmpty) {
      setState(() {
        _emailError = 'Please enter your email address'; // ده هيخلي البوردر يقلب أحمر تلقائي في الـ AppTextField بتاعك
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email address'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_isLoading) return;
    setState(() => _isLoading = true);

    try {
      await _authApiService.requestOtp(email: email);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP sent. Please check your email.'),
          backgroundColor: AppColors.primary500,
        ),
      );

      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => VerificationCodePage(
            email: email,
            isForRegistration: false,
          ),
        ),
      );
    } on AuthException catch (e) {
      if (!mounted) return;
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

                // Back Button - تحريك السهم شمال شوية باستخدام Transform
                Transform.translate(
                  offset: const Offset(-15, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white, // غيرته لأبيض عشان يمشي مع الـ Dark Background
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
                  'Reset your password',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppResponsive.hp(context, 4)),

                // Form
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppResponsive.wp(context, 1)),
                  child: Column(
                    children: [
                      AppTextField(
                        hint: 'Enter your email address',
                        keyboardType: TextInputType.emailAddress,
                        prefixIconData: Icons.email_outlined,
                        controller: _emailController,
                        errorText: _emailError, // بياخد قيمة الـ Error عشان يلون البوردر أحمر
                        onChanged: (value) {
                          if (_emailError != null) {
                            setState(() => _emailError = null); // يرجع اللون طبيعي لما يكتب
                          }
                        },
                      ),

                      SizedBox(height: AppResponsive.hp(context, 4)),
                      PrimaryButton(
                        label: _isLoading ? 'Sending code...' : 'Submit',
                        onPressed: _handleSubmit,
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