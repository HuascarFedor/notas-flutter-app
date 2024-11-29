import 'package:notas_flutter/models/nota.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:logger/logger.dart';

class Log {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // Muestra 2 niveles de llamadas en la pila
      errorMethodCount: 5, // Muestra 5 niveles para errores
      lineLength: 120, // Longitud máxima de línea
      colors: true, // Salida coloreada
      printEmojis: true, // Emojis en mensajes
      printTime: true, // Imprimir timestamps
    ),
  );

  static void debug(dynamic message) => _logger.d(message);
  static void info(dynamic message) => _logger.i(message);
  static void warning(dynamic message) => _logger.w(message);
  static void error(dynamic message) => _logger.e(message);
  static void verbose(dynamic message) => _logger.v(message);
}

class TodoRepository {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    //deleteDatabaseFile();
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'test.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE Notas (
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      content TEXT NOT NULL, 
      finished INTEGER DEFAULT 0, 
      created_at TEXT DEFAULT (DATETIME('now'))
    )
  ''');
  }

  Future<void> deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'notas.db');
    //print(path);
    await deleteDatabase(path);
  }

  Future<List<Nota>> getAllNotas() async {
    //final dbPath = await getDatabasesPath();
    //Log.info("Archivo de base de datos eliminado: $dbPath");
    final db = await database;
    final List<Map<String, dynamic>> notasMap = await db.query('Notas');
    return notasMap.map((notaMap) => Nota.fromMap(notaMap)).toList();
  }

  Future<int> insertNota(Nota nota) async {
    final db = await database;
    int id = await db.insert('Notas', nota.toMap());
    return id;
  }

  Future<void> deleteNota(Nota nota) async {
    final db = await database;
    await db.delete(
      'Notas',
      where: 'id = ?',
      whereArgs: [nota.id],
    );
  }

  Future<void> notaFinished(int id, bool value) async {
    final db = await database;
    await db.update(
      'Notas',
      {'finished': value ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
