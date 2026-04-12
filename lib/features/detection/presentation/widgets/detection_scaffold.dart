import 'package:flutter/material.dart';
import 'package:true_vision/features/detection/core/detection_theme.dart';

/// Scaffold بخلفية داكنة موحّدة لشاشات الـ Detection.
class DetectionScaffold extends StatelessWidget {
  const DetectionScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.padding,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DetectionTheme.backgroundDark,
      appBar: appBar,
      body: SafeArea(
        child: padding != null
            ? Padding(
                padding: padding!,
                child: body,
              )
            : body,
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
