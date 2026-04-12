import 'package:flutter/material.dart';
import 'package:true_vision/core/constants/app_images.dart';
import 'package:true_vision/core/responsive/app_responsive.dart';
import 'package:true_vision/core/theme/app_colors.dart';
import 'package:true_vision/core/widgets/app_text_field.dart';
import 'package:true_vision/core/widgets/primary_button.dart';
import 'package:true_vision/features/auth/presentation/pages/sign_in_page.dart';
import 'package:true_vision/features/auth/presentation/pages/verification_code_page.dart';
import 'package:true_vision/features/auth/presentation/widgets/auth_background.dart';
import '../../data/auth_api_service.dart';
import '../../data/token_storage.dart';
import '../../../../core/widgets/social_login_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  static const String routeName = '/sign-up';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  late TokenStorage _tokenStorage;
  late AuthApiService _authApiService;

  bool _isLoading = false;

  // ===== Error states =====
  String? _firstNameError;
  String? _lastNameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    _tokenStorage = TokenStorage();
    await _tokenStorage.init();
    _authApiService = AuthApiService(tokenStorage: _tokenStorage);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _validateForm() {
    setState(() {
      _firstNameError = _firstNameController.text.trim().isEmpty
          ? 'First name is required'
          : null;

      _lastNameError = _lastNameController.text.trim().isEmpty
          ? 'Last name is required'
          : null;

      _emailError = _emailController.text.trim().isEmpty
          ? 'Email is required'
          : null;

      _passwordError = _passwordController.text.isEmpty
          ? 'Password is required'
          : null;

      _confirmPasswordError =
          _confirmPasswordController.text != _passwordController.text
          ? 'Passwords do not match'
          : null;
    });

    return _firstNameError == null &&
        _lastNameError == null &&
        _emailError == null &&
        _passwordError == null &&
        _confirmPasswordError == null;
  }

  Future<void> _handleRegister() async {
    if (!_validateForm()) return;

    setState(() => _isLoading = true);

    try {
      await _authApiService.register(
        email: _emailController.text.trim(),
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        password: _passwordController.text,
      );

      await _authApiService.requestOtp(email: _emailController.text.trim());

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Registration successful. Enter OTP to verify your email.',
          ),
        ),
      );

      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => VerificationCodePage(
            email: _emailController.text.trim(),
            isForRegistration: true,
          ),
        ),
      );
    } on AuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message)));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong. Please try again.'),
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: AppResponsive.hp(context, 6)),
              Image.asset(
                AppImages.logo2,
                width: AppResponsive.wp(context, 40),
                height: AppResponsive.wp(context, 20),
              ),
              SizedBox(height: AppResponsive.hp(context, 1)),
              Text(
                'Create new account',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: AppResponsive.hp(context, 1)),
              Text(
                'Unlock the power of detecting deepfakes',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textPrimary.withValues(alpha: 0.8),
                ),
              ),
              SizedBox(height: AppResponsive.hp(context, 2)),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppResponsive.wp(context, 1),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: AppTextField(
                            hint: 'First Name',
                            controller: _firstNameController,
                            errorText: _firstNameError,
                            onChanged: (_) =>
                                setState(() => _firstNameError = null),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: AppTextField(
                            hint: 'Last Name',
                            controller: _lastNameController,
                            errorText: _lastNameError,
                            onChanged: (_) =>
                                setState(() => _lastNameError = null),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppResponsive.hp(context, 2)),

                    AppTextField(
                      hint: 'Enter your email',
                      keyboardType: TextInputType.emailAddress,
                      prefixIconData: Icons.email_outlined,
                      controller: _emailController,
                      errorText: _emailError,
                      onChanged: (_) => setState(() => _emailError = null),
                    ),

                    SizedBox(height: AppResponsive.hp(context, 2)),

                    AppTextField(
                      hint: 'Enter your password',
                      obscureText: true,
                      controller: _passwordController,
                      errorText: _passwordError,
                      onChanged: (_) => setState(() => _passwordError = null),
                    ),

                    SizedBox(height: AppResponsive.hp(context, 2)),

                    AppTextField(
                      hint: 'Confirm your password',
                      obscureText: true,
                      controller: _confirmPasswordController,
                      errorText: _confirmPasswordError,
                      onChanged: (_) =>
                          setState(() => _confirmPasswordError = null),
                    ),

                    SizedBox(height: AppResponsive.hp(context, 2)),

                    PrimaryButton(
                      label: _isLoading ? 'Creating account...' : 'Sign-up',
                      onPressed: _isLoading ? null : _handleRegister,
                    ),

                    SizedBox(height: AppResponsive.hp(context, 2)),

                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppColors.textPrimary.withValues(alpha: 0.8),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'or sign-up with',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: AppColors.textPrimary.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: AppResponsive.hp(context, 1)),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialLoginButton(
                          imagePath: AppImages.google,
                          onTap: () {},
                        ),
                        const SizedBox(width: 2),
                        SocialLoginButton(
                          imagePath: AppImages.facebook,
                          onTap: () {},
                        ),
                      ],
                    ),

                    SizedBox(height: AppResponsive.hp(context, 2)),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account ? ',style: TextStyle(fontSize: 18,),),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute<void>(
                                builder: (_) => const SignInPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Sign-in',
                            style: TextStyle(
                              color: AppColors.primary500,

                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppResponsive.hp(context, 2)),
            ],
          ),
        ),
      ),
    );
  }
}
