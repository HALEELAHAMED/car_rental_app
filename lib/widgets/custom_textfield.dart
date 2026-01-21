import 'package:car_rental_application/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final int? maxLines;
  final String? hintText;
  final String? labelText;
  final String? suffixText;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final VoidCallback? onEmojiPressed;
  final FocusNode? focusNode;
  final bool isReadOnly;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final bool disableShadow;
  final double borderRadius;
  final Function(String)? onSubmitted;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final String? errorText;
  final bool allowLeadingZero;

  const CustomTextfield({
    super.key,
    required this.controller,
    this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines,
    this.prefixIcon,
    this.validator,
    this.onEmojiPressed,
    this.focusNode,
    this.isReadOnly = false,
    this.disableShadow = false,
    this.borderRadius = 6,
    this.labelText,
    this.suffixIcon,
    this.suffixText,
    this.onChanged,
    this.textInputAction,
    this.onSubmitted,
    this.textCapitalization = TextCapitalization.none,
    this.errorText,
    this.allowLeadingZero = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSingleLine = maxLines == null || maxLines == 1;

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 50),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType ?? TextInputType.text,
        obscureText: obscureText,
        maxLines: maxLines ?? 1,
        readOnly: isReadOnly,
        onChanged: onChanged,
        textInputAction: textInputAction,
        onFieldSubmitted: onSubmitted,
        textCapitalization: textCapitalization,
        style: TextStyle(
          color: AppColors.primaryBlue,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
          height: 1.3, 
        ),
        inputFormatters: allowLeadingZero
            ? null 
            : [FilteringTextInputFormatter.deny(RegExp(r'^0'))],
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryBlue,
          ),
          hintText: hintText,
          suffixText: suffixText,
          hintStyle: TextStyle(
            color: AppColors.primaryBlue,
            fontFamily: 'Inter',
            fontSize: 16,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: isSingleLine ? 16.h : 12.h,
          ),
          filled: true,
          fillColor: Colors.transparent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius.r),
            borderSide: const BorderSide(color: AppColors.primaryBlue),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius.r),
            borderSide: const BorderSide(color: AppColors.primaryBlue),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius.r),
            borderSide: const BorderSide(
              color: AppColors.primaryBlue,
              width: 2,
            ),
          ),

          errorText: errorText,
          errorStyle: TextStyle(
            color: AppColors.red,
            fontSize: 12,
            fontFamily: 'Inter',
            height: 1.2,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius.r),
            borderSide: const BorderSide(color: AppColors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius.r),
            borderSide: const BorderSide(color: AppColors.red, width: 2),
          ),
          alignLabelWithHint: !isSingleLine,
          suffixIcon: suffixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: suffixIcon,
                )
              : null,
        ),
        validator:
            validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'Enter your $hintText';
              }
              return null;
            },
      ),
    );
  }
}
