import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const Color primaryBackgroundLightColor = Color(0xFF277A68);
  static const Color primaryBackgroundDarkColor = Color(0xFF0E1728);
  static const Color authCardBackground = Color(0xFF101C30);
  static const Color primaryButtonDark = Color(0xFF237374);
  static const Color primaryButtonLight = Color(0xFF3EB372);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF0A1832);
  static const Color skipColor = Color(0xFF96BAC9);
  static const Color lightTextSecondary = Color(0xFF6F7D7D);

  // Dashboard-specific colors
  static const Color accentTeal = Color(
    0xFF96BAC9,
  ); // Light teal for headings, active nav
  static const Color aiBadgeRed = Color(
    0xFFE53935,
  ); // Red for AI Generated badge
  static const Color faceSwapBadge = Color(
    0xFFD4A574,
  ); // Light yellow/beige for Face Swap
  static const Color cardContentBg = Color(
    0xFF151E32,
  ); // Slightly lighter for card content
}
