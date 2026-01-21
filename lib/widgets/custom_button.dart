import 'package:car_rental_application/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_text.dart';

enum ButtonStyleType { blue, gold, grey }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final ButtonStyleType styleType;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = 350,
    this.height = 45,
    this.styleType = ButtonStyleType.blue,
    this.backgroundColor,
    this.textColor,
    this.isLoading = false, // default false
  });

  @override
  Widget build(BuildContext context) {
    final bg =
        backgroundColor ??
        (styleType == ButtonStyleType.blue
            ? AppColors.primaryBlue
            : AppColors.gold);
    final txtColor = textColor ?? AppColors.white;

    return SizedBox(
      width: width.w,
      height: height.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onPressed,
        child: isLoading
            ? SizedBox(
                height: 20.h,
                width: 20.h,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : CustomText(
                text: text,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: txtColor,
              ),
      ),
    );
  }
}
