import 'package:big_bites/context/app_colors.dart';
import 'package:flutter/material.dart';

class AppButtonWidget extends StatelessWidget {
  const AppButtonWidget(
      {super.key,
      required this.child,
      this.height,
      this.elevation = 0,
      this.color,
      this.width,
      this.borderRadius = 20,
      this.onButtonPressed});
  final Widget child;
  final double? height;
  final double? width;
  final double borderRadius;
  final Color? color;
  final double elevation;
  final VoidCallback? onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onButtonPressed,
      height: height,
      minWidth: width,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius)),
      color: color ?? AppColors.primaryColor,
      splashColor: Colors.transparent,
      elevation: elevation,
      child: child,
    );
  }
}
