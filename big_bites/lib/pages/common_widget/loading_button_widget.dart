import 'package:big_bites/context/app_colors.dart';
import 'package:flutter/material.dart';

class LoadingButtonWidget extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  final Widget child;
  final double? width;
  final double? height;
  final double? borderRadius;
  final Color? color;

  const LoadingButtonWidget({
    Key? key,
    required this.isLoading,
    required this.onPressed,
    required this.child,
    this.width,
    this.height,
    this.borderRadius,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 50,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : child,
      ),
    );
  }
}
