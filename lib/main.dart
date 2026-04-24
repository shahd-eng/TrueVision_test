import 'package:flutter/material.dart';
import 'package:true_vision/core/theme/app_theme.dart';
import 'package:true_vision/features/auth/presentation/pages/splash_page.dart';

import 'package:true_vision/features/auth/data/auth_service_manager.dart';
import 'package:true_vision/features/detection/presentation/pages/media_type_page.dart';
import 'package:true_vision/features/profile/pages/payment_method_page.dart';

import 'features/auth/presentation/pages/forgot_password_page.dart';
import 'features/auth/presentation/pages/reset_success_page.dart';
import 'features/dashboard/pages/dashboard_home_page.dart';
import 'features/detection/presentation/pages/choose_function_page.dart';
import 'features/profile/pages/download_data_page.dart';
import 'features/profile/pages/help_support_page.dart';
import 'features/profile/pages/notifications-settings_page.dart';
import 'features/profile/pages/privacy_security_page.dart';
import 'features/profile/pages/profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthServiceManager().initialize();
  runApp(const TrueVisionApp());
}

class TrueVisionApp extends StatelessWidget {
  const TrueVisionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TrueVision',
      theme: AppTheme.light,
      home:  DashboardHomePage(),
    );
  }
}
