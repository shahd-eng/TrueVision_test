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
  });

  final String? hint;
  final bool obscureText;
  final TextInputType? keyboardType;
  final IconData? prefixIconData;
  final String? errorText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
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