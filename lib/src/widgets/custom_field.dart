import 'package:banca_creditos/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData? prefixIcon;
  final String? label;

  CustomTextField(
      {required this.hintText,
      required this.controller,
      this.prefixIcon,
      this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: GoogleFonts.openSans(
              fontSize: responsiveFontSize(15, null),
              fontWeight: FontWeight.w400,
              color: const Color(0xFF808A93),
            ),
          ),
        if (label != null)
          SizedBox(
            height: responsiveHeight(size: 14),
          ),
        Container(
          height: 40,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 0.50, color: Color(0xFFC8D0D9)),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: TextField(
            controller: controller,
            style: const TextStyle(
              color: Colors.black, // Color del texto ingresado
              fontSize: 14,
              fontFamily: 'Product Sans',
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              hintText: hintText, // Placeholder del TextField
              hintStyle: const TextStyle(
                color: Color(0xFFB1B5BB), // Color del placeholder
                fontSize: 14,
                fontFamily: 'Product Sans',
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none, // Quita el borde predeterminado
              prefixIcon: prefixIcon != null
                  ? Icon(
                      prefixIcon,
                      color: Colors
                          .grey, // Color del icono (puedes ajustarlo según necesites)
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
