import 'package:big_bites/context/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField(
      {super.key,
      required this.name,
      this.textStyle,
      this.maxLines = 1,
      this.hint,
      this.hintStyle,
      this.radius = 10,
      this.initialValue,
      this.isObscure = false,
      this.validator,
      this.minLines,
      this.suffix,
      this.suffixIcon,
      this.suffixIconColor});
  final String name;
  final String? initialValue;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final int maxLines;
  final int? minLines;
  final String? hint;
  final double radius;
  final bool isObscure;
  final Widget? suffix;
  final Widget? suffixIcon;
  final Color? suffixIconColor;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      obscureText: isObscure,
      initialValue: initialValue,
      validator: validator,
      minLines: minLines,
      style: textStyle ?? Fonts.bodyMediumInter,
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        hintText: hint ?? '',
        suffix: suffix,
        suffixIcon: suffixIcon,
        suffixIconColor: suffixIconColor,
        hintStyle: hintStyle ?? const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(
            color: Color(0xFFD9D9D9),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Color(0xFFD9D9D9),
          ),
        ),
      ),
    );
  }
}
