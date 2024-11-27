import 'package:big_bites/context/app_colors.dart';
import 'package:flutter/material.dart';

class AppButtonWidget extends StatelessWidget {
  const AppButtonWidget(
      {super.key, required this.child, this.height, this.elevation = 0});
  final Widget child;
  final double? height;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      height: height,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: AppColors.primaryColor,
      splashColor: Colors.transparent,
      elevation: elevation,
      child: child,
    );
  }
}
