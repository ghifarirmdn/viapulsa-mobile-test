import 'package:flutter/material.dart';
import 'package:viapulsa_mobile_test/app/constants/app_colors.dart';

class MyFormInput extends StatelessWidget {
  const MyFormInput({
    super.key,
    this.validator,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.obscureText,
    this.maxLines,
    this.contentPadding,
    this.textInputAction,
    this.autoFocus,
    this.keyboardType,
    this.readOnly,
    this.onFieldSubmitted,
    this.initialValue,
    this.onChanged,
  });
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final bool? obscureText;
  final int? maxLines;
  final EdgeInsetsGeometry? contentPadding;
  final TextInputAction? textInputAction;
  final bool? autoFocus;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final Function(String)? onFieldSubmitted;
  final String? initialValue;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onFieldSubmitted,
      obscureText: obscureText ?? false,
      autofocus: autoFocus ?? false,
      keyboardType: keyboardType,
      validator: validator,
      controller: controller,
      textInputAction: textInputAction,
      readOnly: readOnly ?? false,
      maxLines: maxLines ?? 1,
      onChanged: onChanged,
      initialValue: initialValue,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColor.grey200,
            fontWeight: FontWeight.w600,
          ),
      decoration: InputDecoration(
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: AppColor.red,
            width: 2,
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: AppColor.secondary,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColor.grey200,
              fontWeight: FontWeight.w600,
            ),
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
