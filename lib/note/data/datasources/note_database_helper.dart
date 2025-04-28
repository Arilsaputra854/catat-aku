import 'package:catat_aku/note/data/models/note_model.dart';
import 'package:catat_aku/note/domain/entities/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NoteDatabaseHelper {
  static final NoteDatabaseHelper _instance = NoteDatabaseHelper._internal();
  static Database? _database;

  factory NoteDatabaseHelper() => _instance;

  NoteDatabaseHelper._internal();

  Future<Database> get database async{
    _database ??= await _initDB();
    return _database!;
  }


  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'notes.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE notes(
          id TEXT PRIMARY KEY,
          name TEXT,
          note TEXT,
          create_at TEXT,
          update_at TEXT
        ) 
        ''');
      },
    );
  }

  Future<void> insertNote(NoteModel note) async {
    final db = await database;
    await db.insert('notes', note.toJson());
  }

  Future<List<Note>> getNotes() async{
    final db = await database;
    final result = await db.query('notes');
    return result.map((e)=>NoteModel.fromJson(e)).toList();
  }
  
  Future<void> updateNote(NoteModel note) async{
    final db = await database;
    await db.update('notes', note.toJson(), where: 'id = ?', whereArgs: [note.id]);
  }

  Future<void> deleteNote(String id) async{
    final db = await database;
    await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
