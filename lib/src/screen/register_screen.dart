import 'package:banca_creditos/src/controllers/auth_controller.dart';
import 'package:banca_creditos/src/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/user_model.dart';
import '../utils/responsive.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final AuthController userController = Get.put(AuthController());

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: responsiveHeight(size: 96)),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  width: responsiveWidth(size: 327),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'lib/src/asset/bank-logo.png',
                            height: responsiveWidth(size: 21.5),
                            width: responsiveWidth(size: 21.5),
                          ),
                          SizedBox(
                            width: responsiveWidth(size: 8),
                          ),
                          Text(
                            'Banca créditos',
                            style: GoogleFonts.openSans(
                              fontSize: responsiveFontSize(28, null),
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: responsiveHeight(size: 28),
                      ),
                      Text(
                        'Regístrate',
                        style: GoogleFonts.openSans(
                          fontSize: responsiveFontSize(28, null),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: responsiveHeight(size: 4),
                      ),
                      Text(
                        'Solo te tomará unos minutos.',
                        style: GoogleFonts.openSans(
                          fontSize: responsiveFontSize(15, null),
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF91A1B2),
                        ),
                      ),
                      SizedBox(height: responsiveHeight(size: 26)),
                      CustomTextField(
                        label: 'Nombre completo',
                        controller: nameController,
                        hintText: 'Escribe tu nombre',
                        prefixIcon: Icons.person_2_outlined,
                      ),
                      SizedBox(
                        height: responsiveHeight(size: 14),
                      ),
                      CustomTextField(
                        label: 'Identificación',
                        controller: idController,
                        hintText: 'Escribe tu número de identificación',
                      ),
                      SizedBox(
                        height: responsiveHeight(size: 14),
                      ),
                      CustomTextField(
                        label: 'Email',
                        controller: emailController,
                        hintText: 'Uname@mail.com',
                        prefixIcon: Icons.person_2_outlined,
                      ),
                      SizedBox(
                        height: responsiveHeight(size: 14),
                      ),
                      CustomTextField(
                        label: 'Contraseña',
                        controller: passController,
                        hintText: 'Password',
                        prefixIcon: Icons.lock_outline,
                      ),
                      SizedBox(
                        height: responsiveHeight(size: 25),
                      ),
                      Container(
                        width: responsiveWidth(size: 327),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 25,
                                width: 25,
                                child: Checkbox(
                                  checkColor: Colors.white,
                                  activeColor: const Color(0xFF5428F1),
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value!;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: responsiveWidth(size: 5)),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Acepto los ',
                                        style: TextStyle(
                                          fontSize:
                                              responsiveFontSize(14, null),
                                          fontWeight: FontWeight.w400,
                                          color: Colors
                                              .black, // Establece el color del primer tramo
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Términos y Condiciones',
                                        style: GoogleFonts.openSans(
                                          fontSize:
                                              responsiveFontSize(14, null),
                                          fontWeight: FontWeight.w400,
                                          color: Color(
                                              0xFF5428F1), // Establece el color del segundo tramo
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' y la ',
                                        style: TextStyle(
                                          fontSize:
                                              responsiveFontSize(14, null),
                                          fontWeight: FontWeight.w400,
                                          color: Colors
                                              .black, // Establece el color del tercer tramo
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Política de privacidad',
                                        style: GoogleFonts.openSans(
                                          fontSize:
                                              responsiveFontSize(14, null),
                                          fontWeight: FontWeight.w400,
                                          color: Color(
                                              0xFF5428F1), // Establece el color del segundo tramo
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' de Banca Créditos',
                                        style: TextStyle(
                                          fontSize:
                                              responsiveFontSize(14, null),
                                          fontWeight: FontWeight.w400,
                                          color: Colors
                                              .black, // Establece el color del tercer tramo
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ]),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: responsiveHeight(size: 17)),
                  width: responsiveWidth(size: 358),
                  child: Column(
                    children: [
                      CustomButton(
                        onPressed: () => {
                          userController.insertUser(
                            name: nameController.text,
                            identification: idController.text,
                            email: emailController.text,
                            password: passController.text,
                          )
                        },
                        text: 'Continuar',
                        isSecondary: true,
                      ),
                      SizedBox(
                        height: responsiveHeight(size: 20),
                      ),
                      InkWell(
                        onTap: () => {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          )
                        },
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '¿Ya tienes una cuenta?',
                                style: TextStyle(
                                    fontSize: responsiveFontSize(14, null),
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF808A93)),
                              ),
                              TextSpan(
                                text: ' Inicia sesión',
                                style: GoogleFonts.openSans(
                                  fontSize: responsiveFontSize(14, null),
                                  fontWeight: FontWeight.w400,
                                  color: Color(
                                      0xFF5428F1), // Establece el color del segundo tramo
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
