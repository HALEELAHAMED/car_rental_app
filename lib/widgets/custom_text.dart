import 'package:car_rental_application/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final String? fontFamily;
  final TextStyle? style;
  final bool? softWrap;

  const CustomText({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.fontFamily,
    this.style,
    this.softWrap,
  });

  TextStyle getDefaultStyle(Color? parentColor) {
    final effectiveColor = color ?? AppColors.primaryBlue;

    switch (fontFamily?.toLowerCase()) {
      case 'gentium':
        return GoogleFonts.gentiumBookPlus(
          fontSize: fontSize?.sp ?? 14,
          fontWeight: fontWeight ?? FontWeight.w400,
          color: effectiveColor,
          decoration: TextDecoration.none,
        );
      case 'inter':
        return GoogleFonts.inter(
          fontSize: fontSize?.sp ?? 14,
          fontWeight: fontWeight ?? FontWeight.w400,
          color: effectiveColor,
          decoration: TextDecoration.none,
        );

      default:
        return GoogleFonts.inter(
          fontSize: fontSize?.sp ?? 14,
          fontWeight: fontWeight ?? FontWeight.w400,
          color: effectiveColor,
          decoration: TextDecoration.none,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final parentColor = DefaultTextStyle.of(context).style.color;
    final textStyle = style ?? getDefaultStyle(parentColor);

    return Text(
      text,
      style: textStyle,
      textAlign: textAlign ?? TextAlign.start,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap ?? true,
    );
  }
}
