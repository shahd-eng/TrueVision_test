import 'package:flutter/material.dart';

class AppContainer extends StatelessWidget {
  final Widget child;
  final double padding;
  final double borderRadius;
  final VoidCallback? onTap;

  const AppContainer({
    super.key,
    required this.child,
    this.padding = 16.0,
    this.borderRadius = 16.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF2F8F83),
        Color(0xFF0B1324),
      ],
    );

    Widget container = Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: gradient,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: container,
      );
    }

    return container;
  }
}
