import 'package:flutter/material.dart';
import 'package:true_vision/core/constants/app_images.dart';
import 'package:true_vision/core/responsive/app_responsive.dart';
import 'package:true_vision/core/theme/app_colors.dart';
import 'package:true_vision/core/widgets/app_text_field.dart';
import 'package:true_vision/core/widgets/primary_button.dart';
import 'package:true_vision/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:true_vision/features/auth/presentation/pages/sign_up_page.dart';
import 'package:true_vision/features/auth/presentation/widgets/auth_background.dart';
import 'package:true_vision/features/detection/presentation/pages/choose_function_page.dart';
import 'package:true_vision/features/detection/presentation/pages/media_type_page.dart';

import '../../../../core/widgets/social_login_button.dart';
import '../../data/auth_api_service.dart';
import '../../data/token_storage.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  static const String routeName = '/sign-in';

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _rememberMe = false;
  bool _isLoading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late TokenStorage _tokenStorage;
  late AuthApiService _authApiService;

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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleAdminLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await _authApiService.adminLogin(email: email, password: password);

      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (_) => const ChooseFunctionPage()),
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
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// This method assumes you already obtained a valid Google ID token
  /// from the Google Sign-In flow, then sends it to the backend.
  Future<void> _handleGoogleLogin() async {
    // TODO: Replace this with real Google Sign-In integration and token.
    const String mockGoogleToken = 'REPLACE_WITH_REAL_GOOGLE_ID_TOKEN';

    setState(() => _isLoading = true);
    try {
      await _authApiService.externalLoginWithGoogle(token: mockGoogleToken);

      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Google login successful')));

      // TODO: Navigate to home/dashboard page after successful login.
    } on AuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message)));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong with Google login.'),
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
      backgroundColor: Colors.transparent,

      resizeToAvoidBottomInset: false,
      body: AuthBackground(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: AppResponsive.hp(context, 6)),
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
                  'Welcome Back !',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppResponsive.hp(context, 1)),
                // Subtitle
                Text(
                  'Glad to see you again, Continue your journey',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textPrimary.withValues(alpha: 0.8),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppResponsive.hp(context, 2)),
                // Form Fields
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppResponsive.wp(context, 1),
                  ),
                  child: Column(
                    children: [
                      // Email
                      AppTextField(
                        hint: 'Enter your email',
                        keyboardType: TextInputType.emailAddress,
                        prefixIconData: Icons.email_outlined,
                        controller: _emailController,
                      ),

                      SizedBox(height: AppResponsive.hp(context, 2)),
                      // Password
                      AppTextField(
                        hint: 'Enter your password',
                        obscureText: true,
                        controller: _passwordController,
                      ),

                      SizedBox(height: AppResponsive.hp(context, 1)),
                      // Remember me & Forgot password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    _rememberMe = value ?? false;
                                  });
                                },
                                activeColor: AppColors.primaryButtonLight,
                                checkColor: Colors.white,
                              ),
                              Text(
                                'Remember me',
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) => const ForgotPasswordPage(),
                                ),
                              );
                            },
                            child: Text(
                              'Forgot password?',
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppResponsive.hp(context, 2)),
                      // Sign In Button
                      PrimaryButton(
                        label: _isLoading ? 'Signing in...' : 'Sign-in',
                        onPressed: () {
                          if (_isLoading) return;
                          _handleAdminLogin();
                        },
                      ),
                      SizedBox(height: AppResponsive.hp(context, 2)),
                      // Separator
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: AppColors.textPrimary.withValues(
                                alpha: 0.8,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'or sign-up with',
                              style: TextStyle(
                                color: AppColors.textPrimary.withValues(
                                  alpha: 0.7,
                                ),
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: AppColors.textPrimary.withValues(
                                alpha: 0.8,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppResponsive.hp(context, 2)),
                      // Social Login Icons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SocialLoginButton(
                            imagePath: AppImages.google,
                            onTap: () {
                              if (_isLoading) return;
                              _handleGoogleLogin();
                            },
                          ),
                          const SizedBox(width: 2),
                          SocialLoginButton(
                            imagePath: AppImages.facebook,
                            onTap: () {},
                          ),
                        ],
                      ),
                      SizedBox(height: AppResponsive.hp(context, 3)),
                      // Footer
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 18,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute<void>(
                                  builder: (_) => const SignUpPage(),
                                ),
                              );
                            },
                            child: Text(
                              'Sign-up',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
