import 'package:banca_creditos/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData? prefixIcon;
  final String? label;
  final String? description;
  final bool numbersonly; // Nuevo parámetro para permitir solo números

  CustomTextField({
    required this.hintText,
    required this.controller,
    this.prefixIcon,
    this.label,
    this.description,
    this.numbersonly = false, // Valor predeterminado es false
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final currencyFormatter = NumberFormat("#,##0.00", "es_CO");

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    final text = widget.controller.text;
    final value = int.tryParse(text.replaceAll(RegExp(r'[^0-9]'), ''));

    if (value != null) {
      final newString = currencyFormatter.format(value / 100);
      widget.controller.value = TextEditingValue(
        text: '\$ $newString',
        selection:
            TextSelection.collapsed(offset: '\$ '.length + newString.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Text(
            widget.label!,
            style: GoogleFonts.openSans(
              fontSize: responsiveFontSize(15, null),
              fontWeight: FontWeight.w400,
              color: const Color(0xFF808A93),
            ),
          ),
        if (widget.label != null)
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
          child: TextFormField(
            controller: widget.controller,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Product Sans',
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                color: Color(0xFFB1B5BB),
                fontSize: 14,
                fontFamily: 'Product Sans',
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
              prefixIcon: widget.prefixIcon != null
                  ? Icon(
                      widget.prefixIcon,
                      color: Colors.grey,
                      size: 20,
                    )
                  : null,
            ),
            keyboardType: widget.numbersonly
                ? TextInputType.number
                : TextInputType.text, // Establecer el tipo de teclado
            inputFormatters: widget.numbersonly
                ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
                : null, // Agregar el formatter para permitir solo números
          ),
        ),
      ],
    );
  }
}
