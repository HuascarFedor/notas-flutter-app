import 'package:notas_flutter/models/nota.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TodoRepository {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'nota.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE Notas(id INTEGER PRIMARY KEY AUTOINCREMENT, content TEXT)');
  }

  Future<List<Nota>> getAllNotas() async {
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
}
