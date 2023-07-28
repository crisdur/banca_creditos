import 'package:banca_creditos/src/screen/register_screen.dart';
import 'package:banca_creditos/src/utils/responsive.dart';
import 'package:banca_creditos/src/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/auth_controller.dart';
import '../widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool isChecked = false;
  final AuthController userController = Get.put(AuthController());

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
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Inicia sesión o continua,',
                              style: TextStyle(
                                  fontSize: responsiveFontSize(16, null),
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                            TextSpan(
                              text: 'solo te tomará unos minutos.',
                              style: GoogleFonts.openSans(
                                  fontSize: responsiveFontSize(16, null),
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: responsiveHeight(size: 59)),
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
                          prefixIcon: Icons.lock_outline),
                      SizedBox(
                        height: responsiveHeight(size: 25),
                      ),
                      Container(
                        width: responsiveWidth(size: 327),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 16,
                                    width: 16,
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
                                  Text(
                                    'Recordarme ',
                                    style: GoogleFonts.openSans(
                                      fontSize: responsiveFontSize(14, null),
                                      fontWeight: FontWeight.w400,
                                      color: Colors
                                          .black, // Establece el color del primer tramo
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '¿Olvide mi contraseña?',
                                style: GoogleFonts.openSans(
                                    fontSize: responsiveFontSize(14, null),
                                    fontWeight: FontWeight.w400,
                                    color: Color(
                                        0xFF5428F1) // Establece el color del primer tramo
                                    ),
                              ),
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
                          userController.login(
                              email: emailController.text,
                              password: passController.text)
                        },
                        text: 'Iniciar Sesión',
                        isSecondary: true,
                      ),
                      SizedBox(
                        height: responsiveHeight(size: 25),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterScreen()),
                          );
                        },
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '¿No tienes una cuenta?',
                                style: TextStyle(
                                    fontSize: responsiveFontSize(14, null),
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF808A93)),
                              ),
                              TextSpan(
                                text: ' Registrate',
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
