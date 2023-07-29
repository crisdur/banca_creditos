import 'package:banca_creditos/src/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/responsive.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final void Function()? onPressed;
  final bool isSecondary;
  final bool enabled;
  final bool loading;
  final int? maxLines;
  final Widget? child;
  final double height;
  final double? fontSize;
  final Color? buttonColor;
  final Color? fontColor;
  const CustomButton({
    Key? key,
    this.text,
    required this.onPressed,
    this.isSecondary = false,
    this.maxLines,
    this.child,
    this.enabled = true,
    this.loading = false,
    this.height = 50.0,
    this.fontSize,
    this.buttonColor,
    this.fontColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: responsiveHeight(size: height),
      child: InkWell(
        onTap: enabled == true && loading == false ? onPressed : null,
        child: Container(
          width: double.infinity, // Occupy the entire available width
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: buttonColor ??
                (isSecondary ? AppColors.secondary : AppColors.primary),
            borderRadius: BorderRadius.circular(10),
          ),
          child: loading == true
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ))
              : text == null
                  ? SizedBox()
                  : Text(
                      text!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sourceSansPro(
                        fontSize: responsiveFontSize(fontSize ?? 16, null),
                        color: fontColor ??
                            (isSecondary ? Colors.white : Colors.black),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
        ),
      ),
    );
  }
}
