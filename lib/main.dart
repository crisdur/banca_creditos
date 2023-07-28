import 'package:banca_creditos/sql_helper.dart';
import 'package:banca_creditos/src/screen/authentication_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller_bindings.dart';
import 'src/controllers/auth_controller.dart';
import 'src/screen/home_screen.dart';
import 'src/screen/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: ControllerBindings(),
      title: 'Banca créditos',
      theme: ThemeData(backgroundColor: Colors.white),
      home: GetBuilder<AuthController>(
        builder: (_) {
          return SafeArea(child: AuthenticationSelectionScreen());

          //        _.isLogged == false
          //        ? const HomeScreen()
          //        : const LoginScreen());
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
