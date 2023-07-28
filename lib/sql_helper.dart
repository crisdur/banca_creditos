import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlHelper {
  static final SqlHelper _instance = SqlHelper.internal();

  factory SqlHelper() => _instance;

  SqlHelper.internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    // Obtenemos la ruta de la base de datos
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "myapp.db");

    // Abrimos la base de datos
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    // Creamos las tablas
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY,
        name TEXT,
        identification TEXT,
        email TEXT,
        password TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE loans (
        id INTEGER PRIMARY KEY,
        userId INTEGER,
        moto TEXT,
        FOREIGN KEY (userId) REFERENCES users(id)
      )
    ''');
  }

  // Métodos para operaciones CRUD de usuarios
  Future<int> insertUser(Map<String, dynamic> user) async {
    Database db = await database;
    return await db.insert('users', user);
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    Database db = await database;
    return await db.query('users');
  }

  // Métodos para operaciones CRUD de préstamos
  Future<int> insertLoan(Map<String, dynamic> loan) async {
    Database db = await database;
    return await db.insert('loans', loan);
  }

  Future<List<Map<String, dynamic>>> getAllLoans() async {
    Database db = await database;
    return await db.query('loans');
  }

  // Otros métodos que puedas necesitar, como obtener un usuario o préstamo específico por ID, etc.
}
