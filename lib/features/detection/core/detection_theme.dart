import 'package:flutter/material.dart';

/// ألوان وثيمات موحّدة لقسم الـ Detection.
/// يُستخدم في كل شاشات الـ Detection للحفاظ على نفس المظهر.
class DetectionTheme {
  DetectionTheme._();

  // ─── خلفيات ─────────────────────────────────────────────────────────────
  static const Color backgroundDark = Color(0xFF0E1728);
  static const Color cardDark = Color(0xFF101C30);
  static const Color surfaceDark = Color(0xFF0F1419);

  // ─── ألوان التمييز (Teal / Green) ────────────────────────────────────────
  static const Color tealAccent = Color(0xFF00C896);
  static const Color darkerTeal = Color(0xFF1A5F5D);

  // ─── ألوان من AppColors نعيد تصديرها للاستخدام الموحّد ───────────────────
  static const Color primaryLight = Color(0xFF2F8F83);
  static const Color primaryDark = Color(0xFF0E1728);

  // ─── ألوان الأزرار والتحذير ─────────────────────────────────────────────
  static const Color cancelRed = Color(0xFFE85D4F);
  static const Color downloadBorder = Color(0xFF2D3748);
  static const Color textOnDark = Color(0xFF1A202C);

  // ─── ألوان شريط الاشتباه (Suspicious Segments) ───────────────────────────
  static const Color segmentGreen = Color(0xFF22C55E);
  static const Color segmentYellow = Color(0xFFEAB308);
  static const Color segmentRed = Color(0xFFEF4444);
  static const Color segmentOrange = Color(0xFFF97316);
  static const Color segmentRedDark = Color(0xFFDC2626);
  static const Color segmentLime = Color(0xFF84CC16);

  // ─── جراديانت الـ Upload والزر الرئيسي ──────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryLight, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient tealGradient = LinearGradient(
    colors: [darkerTeal, tealAccent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient suspicionTimelineGradient = LinearGradient(
    colors: [segmentGreen, segmentYellow, segmentRed],
    stops: [0.0, 0.45, 1.0],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // ─── جراديانت شارات النسبة في الـ Segments ──────────────────────────────
  static const List<Color> percentBadgeYellowOrange = [
    Color(0xFFEAB308),
    Color(0xFFF97316),
  ];
  static const List<Color> percentBadgeRed = [
    Color(0xFFEF4444),
    Color(0xFFDC2626),
  ];
  static const List<Color> percentBadgeGreen = [
    Color(0xFF84CC16),
    Color(0xFF22C55E),
  ];
}
