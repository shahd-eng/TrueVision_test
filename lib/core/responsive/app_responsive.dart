import 'package:flutter/material.dart';

class AppResponsive {
  const AppResponsive._();

  static Size sizeOf(BuildContext context) => MediaQuery.sizeOf(context);

  static double height(BuildContext context) => sizeOf(context).height;

  static double width(BuildContext context) => sizeOf(context).width;

  static double hp(BuildContext context, double percent) =>
      height(context) * percent / 100;

  static double wp(BuildContext context, double percent) =>
      width(context) * percent / 100;
}



