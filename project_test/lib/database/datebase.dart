// database/database_helper.dart
import 'package:Memo/database/noteModel.dart';
import 'package:Memo/database/userModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static final SqlDb _initDB = SqlDb._internal();
  factory SqlDb() => _initDB;
  SqlDb._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'memo_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE notes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        created_at TEXT NOT NULL,
        user_id INTEGER NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
      );
    ''');
  }

  Future<int> insertUser(User user) async {
    final Database db = await database;
    return await db.rawInsert(
      '''
      INSERT INTO users (username, email, password) VALUES (?, ?, ?)
    ''',
      [user.username, user.email, user.password],
    );
  }

  Future<User?> getUserByEmail(User user) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      '''
      SELECT * FROM users WHERE email = ?
    ''',
      [user.email],
    );
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<User?> loginUser(String email, String password) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      '''
      SELECT * FROM users WHERE email = ? AND password = ?
    ''',
      [email, password],
    );
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<bool> userExists(String email) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      '''
      SELECT * FROM users WHERE email = ?
    ''',
      [email],
    );
    return maps.isNotEmpty;
  }

  Future<int> updateUser(User user) async {
    final db = await database;
    return await db.rawUpdate(
      '''
      UPDATE users SET username = ?, email = ?, password = ? WHERE id = ?
    ''',
      [user.username, user.email, user.password, user.id],
    );
  }

  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.rawDelete(
      '''
      DELETE FROM users WHERE id = ?
    ''',
      [id],
    );
  }

  Future<int> insertNote(Notemodel note) async {
    final Database db = await database;
    return await db.rawInsert(
      '''
      INSERT INTO notes (title, content, created_at, user_id) VALUES (?, ?, ?, ?)
    ''',
      [note.title, note.content, note.createdAt.toString(), note.userId],
    );
  }

  Future<List<Notemodel>> getNotesByUserId(int userId) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      '''
      SELECT * FROM notes WHERE user_id = ?
    ''',
      [userId],
    );
    return List.generate(maps.length, (i) {
      return Notemodel.fromMap(maps[i]);
    });
  }

  Future<int> deleteNotesByUser(int userId) async {
    final db = await database;
    return await db.rawDelete(
      '''
      DELETE FROM notes WHERE user_id = ?
    ''',
      [userId],
    );
  }

  Future<int?> getUserIdByEmail(String email) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      '''
      SELECT id FROM users WHERE email = ?
    ''',
      [email],
    );
    if (maps.isNotEmpty) {
      return maps.first['id'] as int;
    }
    return null;
  }
}
