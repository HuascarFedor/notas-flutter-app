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
}
