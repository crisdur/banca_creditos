import 'package:banca_creditos/src/screen/home_screen.dart';
import 'package:banca_creditos/src/screen/login_screen.dart';
import 'package:banca_creditos/src/screen/sucess_register_screen.dart';
import 'package:banca_creditos/src/screen/tabs_screen.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../../sql_helper.dart';
import '../models/user_model.dart';

class AuthController extends GetxController {
  var rememberPass = false;

  Rx<UserModel?> currentUser = Rx<UserModel?>(null);

  final dbHelper = SqlHelper();

  Future<void> insertUser({
    required String name,
    required String identification,
    required String email,
    required String password,
  }) async {
    // Verificar que el nombre no esté vacío
    if (name.isEmpty) {
      Get.snackbar(
        'Error',
        'El nombre no puede estar vacío.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Verificar que la identificación no esté vacía
    if (identification.isEmpty) {
      Get.snackbar(
        'Error',
        'La identificación no puede estar vacía.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Verificar que el email sea válido
    if (!GetUtils.isEmail(email)) {
      Get.snackbar(
        'Error',
        'Ingresa un email válido.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Verificar que la contraseña tenga más de 4 dígitos
    if (password.length < 4) {
      Get.snackbar(
        'Error',
        'La contraseña debe tener al menos 4 caracteres.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    List<Map<String, dynamic>> users = await dbHelper.getAllUsers();

    bool isIdentificationRepeated =
        users.any((user) => user['identification'] == identification);
    bool isEmailRepeated = users.any((user) => user['email'] == email);

    if (isIdentificationRepeated) {
      Get.snackbar(
        'Error',
        'La identificación ya está registrada en la base de datos. Por favor, ingresa otra.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (isEmailRepeated) {
      Get.snackbar(
        'Error',
        'El email ya está registrado en la base de datos. Por favor, ingresa otro.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    Map<String, dynamic> user = {
      'name': name,
      'identification': identification,
      'email': email,
      'password': password,
    };

    int insertedUserId = await dbHelper.insertUser(user);
    print('Usuario insertado con ID: $insertedUserId');

    Get.snackbar(
      'Éxito',
      'Usuario registrado exitosamente.',
      snackPosition: SnackPosition.BOTTOM,
    );

    Get.offAll(LoginScreen());
  }

  Future<List<UserModel>> getUsers() async {
    List<Map<String, dynamic>> userMaps = await dbHelper.getAllUsers();

    // Mapeamos los datos de la lista de mapas a una lista de UserModel.
    List<UserModel> users = userMaps.map((userMap) {
      return UserModel(
        id: userMap['id'],
        name: userMap['name'],
        identification: userMap['identification'],
        email: userMap['email'],
        password: userMap['password'],
      );
    }).toList();

    // Imprimimos los usuarios en la consola.
    print('Usuarios en la base de datos:');
    users.forEach((user) {
      print(
          'ID: ${user.id}, Name: ${user.name}, Identification: ${user.identification}, Email: ${user.email}, Password: ${user.password}');
    });

    return users;
  }

  Future<void> deleteAllData() async {
    Database db = await dbHelper.database;
    await db.delete('users');
    await db.delete('loans');
    print('Toda la información de la base de datos ha sido eliminada.');
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty) {
      Get.snackbar(
        "Error",
        "El correo está vacío",
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    if (password.isEmpty) {
      Get.snackbar(
        "Error",
        "La clave está vacía",
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    List<Map<String, dynamic>> users = await dbHelper.getAllUsers();

    for (var user in users) {
      if (user['email'] == email && user['password'] == password) {
        UserModel loggedInUser = UserModel(
          id: user['id'],
          name: user['name'],
          identification: user['identification'],
          email: user['email'],
          password: user['password'],
        );

        currentUser.value = loggedInUser;

        Get.snackbar(
          "Éxito",
          "Inicio de sesión exitoso",
          snackPosition: SnackPosition.BOTTOM,
        );

        Get.offAll(TabsScreen());
        return true;
      }
    }

    Get.snackbar(
      "Error",
      "Credenciales inválidas. Inicio de sesión fallido",
      snackPosition: SnackPosition.BOTTOM,
    );
    return false;
  }
}
