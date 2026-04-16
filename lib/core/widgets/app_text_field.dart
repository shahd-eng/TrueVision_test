import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.hint,
    this.obscureText = false,
    this.keyboardType,
    this.prefixIconData,
    this.errorText,
    this.controller,
    this.onChanged,
    this.initialValue, // مضاف عشان سكرينات سما (اختياري)
  });

  final String? hint;
  final bool obscureText;
  final TextInputType? keyboardType;
  final IconData? prefixIconData;
  final String? errorText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? initialValue; // مضاف لضمان التوافق

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _isObscured;
  TextEditingController? _effectiveController;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;

    // لو إنتي باعتة controller هيستخدمه، لو مش باعتة وفيه initialValue (شغل سما) هيعمل واحد جديد
    if (widget.controller != null) {
      _effectiveController = widget.controller;
    } else if (widget.initialValue != null) {
      _effectiveController = TextEditingController(text: widget.initialValue);
    }
  }

  @override
  void dispose() {
    // بنمسح الـ controller اللي عملناه يدوي بس عشان ما يستهلكش ميموري
    if (widget.controller == null) {
      _effectiveController?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _effectiveController,
      obscureText: _isObscured,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        hintText: widget.hint,
        errorText: widget.errorText,
        hintStyle: TextStyle(
          color: Colors.white.withValues(alpha: 0.6),
          fontSize: 14,
        ),
        prefixIcon: widget.obscureText
            ? IconButton(
          icon: Icon(
            _isObscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: const Color(0xFF277A68),
            size: 20,
          ),
          onPressed: () {
            setState(() => _isObscured = !_isObscured);
          },
        )
            : (widget.prefixIconData != null
            ? Icon(widget.prefixIconData, color: AppColors.primaryBackgroundLightColor, size: 20)
            : null),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.textPrimary.withValues(alpha: 0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryBackgroundLightColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
      ),
    );
  }
}