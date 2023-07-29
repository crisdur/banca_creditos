import 'package:banca_creditos/src/utils/greet_with_name.dart';
import 'package:banca_creditos/src/widgets/custom_button.dart';
import 'package:banca_creditos/src/widgets/custom_field.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/auth_controller.dart';
import '../utils/formatCash.dart';
import '../utils/responsive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final TextEditingController salaryController = TextEditingController();

final TextEditingController neededLoanController =
    TextEditingController(text: '0');

final TextEditingController monthController = TextEditingController();

bool loadingSimulation = false;

final List<String> items = [
  'Crédito de vehículo (3%)',
  'Crédito de vivienda (1%)',
  'Crédito libre inversión (3.5%)'
];
String? selectedValue;

class _HomeScreenState extends State<HomeScreen> {
  bool _isOutlined = true;
  void _toggleOutlined() {
    setState(() {
      _isOutlined = !_isOutlined;
    });
  }

  bool isPanelVisible = false;

  void togglePanelVisibility() {
    setState(() {
      isPanelVisible = !isPanelVisible;
    });
  }

  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Opacity(
                    opacity: isPanelVisible ? 0.3 : 1,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(() {
                                final currentUser =
                                    authController.currentUser.value;
                                return currentUser != null
                                    ? Text(
                                        greetWithName(currentUser.name),
                                        style: GoogleFonts.openSans(
                                          fontSize:
                                              responsiveFontSize(22, null),
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFF0C1022),
                                        ),
                                      )
                                    : const Text('Error');
                              }),
                              InkWell(
                                onTap: _toggleOutlined,
                                child: Icon(
                                  _isOutlined
                                      ? Icons.notifications_active_outlined
                                      : Icons.notifications_active,
                                  size: 25,
                                  color: const Color(0xFF0C1022),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: responsiveHeight(size: 35),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 24),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Simulador de crédito',
                                style: GoogleFonts.openSans(
                                  fontSize: responsiveFontSize(25, null),
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF5428F1),
                                ),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: responsiveHeight(size: 5),
                                  ),
                                  const Icon(
                                    Icons.info_outline,
                                    size: 25,
                                    color: Color(0xFF5428F1),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.only(left: 24, right: 27),
                          child: Text(
                            textAlign: TextAlign.left,
                            'Ingresa los datos para tu crédito según lo que necesites.',
                            style: GoogleFonts.openSans(
                              fontSize: responsiveFontSize(18, null),
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF0C1022),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.only(left: 31, right: 32),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: responsiveHeight(size: 20),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      '¿Qué tipo de créditos deseas realizar?',
                                      style: GoogleFonts.openSans(
                                          fontSize:
                                              responsiveFontSize(15, null),
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: responsiveHeight(size: 14),
                                    ),
                                  ],
                                ),
                                DropdownButtonFormField<String>(
                                  isExpanded: true,
                                  hint: Text(
                                    'Select Item',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: items
                                      .map((String item) =>
                                          DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  value: selectedValue,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedValue = value;
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 14,
                                ),
                                CustomTextField(
                                  controller: salaryController,
                                  hintText: '\$ 10’000.000,00',
                                  label: '¿Cuánto es tu salario base?',
                                  numbersonly: true,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Digíta tu salario para calcular el préstamo que necesitas',
                                  style: GoogleFonts.openSans(
                                      fontSize: responsiveFontSize(12, null),
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Container(
                                    height: 40,
                                    width: double.infinity,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFC8D0D9),
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            width: 0.50,
                                            color: Color(0xFFC8D0D9)),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(top: 12, left: 14),
                                      child: Text(
                                        (formatCash(neededLoanController.text)),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: 'Product Sans',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    )),
                                const SizedBox(
                                  height: 25,
                                ),
                                CustomTextField(
                                  label: '¿A cuántos meses?',
                                  hintText: '48',
                                  controller: monthController,
                                  numbersonly: true,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Elije un plazo desde 12 hasta 84 meses',
                                  style: GoogleFonts.openSans(
                                      fontSize: responsiveFontSize(12, null),
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                const SizedBox(height: 45),
                                CustomButton(
                                  onPressed: () {
                                    // Validar las condiciones antes de realizar la simulación
                                    if (salaryController.text.isEmpty) {
                                      Get.snackbar(
                                        'Error',
                                        'Por favor, ingresa un salario.',
                                        snackPosition: SnackPosition.BOTTOM,
                                      );
                                      return;
                                    }

                                    if (double.parse(salaryController.text) <
                                        1000000) {
                                      Get.snackbar(
                                        'Error',
                                        'El salario debe ser mayor o igual que 1.000.000.',
                                        snackPosition: SnackPosition.BOTTOM,
                                      );
                                      return;
                                    }

                                    if (selectedValue == '' ||
                                        selectedValue == null) {
                                      Get.snackbar(
                                        'Error',
                                        'El tipo de préstamo  no debe estar vacío.',
                                        snackPosition: SnackPosition.BOTTOM,
                                      );
                                      return;
                                    }

                                    if (monthController.text.isEmpty ||
                                        (int.parse(monthController.text) < 12 ||
                                            int.parse(monthController.text) >
                                                84)) {
                                      Get.snackbar(
                                        'Error',
                                        'Por favor, ingresa un número de meses entre 12 y 84.',
                                        snackPosition: SnackPosition.BOTTOM,
                                      );
                                      return;
                                    }

                                    // Si se cumplen las condiciones, realizar la simulación
                                    setState(() {
                                      neededLoanController
                                          .text = ((double.parse(
                                                      salaryController.text) *
                                                  7) /
                                              15)
                                          .toString();

                                      loadingSimulation = true;
                                    });

                                    Future.delayed(const Duration(seconds: 3),
                                        () {
                                      togglePanelVisibility();
                                      setState(() {
                                        loadingSimulation = false;
                                      });
                                    });
                                  },
                                  text: 'Simular',
                                  isSecondary: true,
                                  loading: loadingSimulation,
                                ),
                              ]),
                        )
                      ],
                    ),
                  ),
                  if (isPanelVisible)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SlidingPanel(
                        onClose: togglePanelVisibility,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SlidingPanel extends StatelessWidget {
  final VoidCallback onClose;

  const SlidingPanel({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: responsiveWidth(size: 331),
        height: 400,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black, // Color del sombreado (negro en este caso)
              offset: Offset(0, 2), // Desplazamiento en la dirección X e Y
              blurRadius: 4.0, // Radio del desenfoque
              spreadRadius:
                  0, // Cómo se propaga el sombreado (0 para que no se propague)
            ),
          ],
        ),
        child: Column(
          children: [
            const SizedBox(height: 16),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: onClose,
            ),
            const Text(
              'Cuota máxima de préstamo',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
