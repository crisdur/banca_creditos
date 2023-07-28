import 'package:banca_creditos/src/screen/login_screen.dart';
import 'package:banca_creditos/src/screen/register_screen.dart';
import 'package:banca_creditos/src/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:google_fonts/google_fonts.dart';

import '../utils/responsive.dart';

class AuthenticationSelectionScreen extends StatefulWidget {
  const AuthenticationSelectionScreen({super.key});

  @override
  AuthenticationSelectionScreenState createState() =>
      AuthenticationSelectionScreenState();
}

class AuthenticationSelectionScreenState
    extends State<AuthenticationSelectionScreen> {
  int _imageIndex = 0;
  double _progress = 0.0;
  Timer? _timer;

  // Lista de imágenes que se mostrarán en el slider
  List<String> _images = [
    'lib/src/asset/welcome-1.png',
    'lib/src/asset/welcome-2.png',
    // Agrega más rutas de imágenes aquí
  ];
  List<String> _text = [
    'Accede a créditos\ncon un solo toque y sin complicaciones.',
    'Toma el control de tus finanzas con confianza y accede a ellas sin restricciones.',
    // Agrega más rutas de imágenes aquí
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    // Cambiar imágenes y actualizar el contador cada 5 segundos
    const duration = const Duration(seconds: 5);
    _timer = Timer.periodic(duration, (_) {
      setState(() {
        _imageIndex = (_imageIndex + 1) % _images.length;
        _progress = 0.0;
      });
    });

    // Actualizar el progreso cada 100 milisegundos
    const progressDuration = const Duration(milliseconds: 100);
    Timer.periodic(progressDuration, (_) {
      setState(() {
        _progress += progressDuration.inMilliseconds / duration.inMilliseconds;
        if (_progress >= 1.0) {
          _progress = 0.0;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(_images[_imageIndex]),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LinearProgressIndicator(
              value: _progress,
              backgroundColor: Colors.grey,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            Column(
              children: [
                Text(
                  _text[_imageIndex],
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 33),
                CustomButton(
                    text: 'Ingresar',
                    onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          )
                        }),
                const SizedBox(height: 15),
                CustomButton(
                    text: 'Registrarme',
                    onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterScreen()),
                          )
                        },
                    isSecondary: true),
                const SizedBox(height: 15),
              ],
            )
          ],
        ),
      ),
    );
  }
}
