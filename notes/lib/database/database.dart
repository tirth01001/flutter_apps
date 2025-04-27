


import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' show join;

class NDatabase {

  static NDatabase instant = NDatabase._intern();
  static Database ? _database;
  NDatabase._intern();


  Future<Database> get db async {
    if(_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  } 

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final dbLocation = join(dbPath,"my_notes.db");
    return await openDatabase(dbLocation,version: 1,onCreate: _onCreate);
  }

  void _onCreate(Database db,int version) async {
    await db.execute('''  
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL DEFAULT '',
        content TEXT NOT NULL DEFAULT '',
        created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
        is_pinned INTEGER NOT NULL DEFAULT 0,
        is_archived INTEGER NOT NULL DEFAULT 0,
        is_deleted INTEGER NOT NULL DEFAULT 0,
        color_hex TEXT NOT NULL DEFAULT '#FFFFFF',
        reminder TEXT,
        mood TEXT NOT NULL DEFAULT '',
        priority TEXT NOT NULL DEFAULT 'normal',
        is_checklist INTEGER NOT NULL DEFAULT 0,
        password_protected INTEGER NOT NULL DEFAULT 0,
        password_hint TEXT DEFAULT '',
        template_name TEXT,
        favorite INTEGER NOT NULL DEFAULT 0,
        auto_save_enabled INTEGER NOT NULL DEFAULT 1,
        note_type TEXT NOT NULL DEFAULT 'text',
        device_name TEXT NOT NULL DEFAULT 'unknown',
        note_language TEXT NOT NULL DEFAULT 'en',
        markdown_enabled INTEGER NOT NULL DEFAULT 0,
        note_layout_style TEXT NOT NULL DEFAULT 'default',
        collapsed INTEGER NOT NULL DEFAULT 0,
        expanded INTEGER NOT NULL DEFAULT 1,
        last_viewed TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
        visible_in_search INTEGER NOT NULL DEFAULT 1,
        note_slug TEXT NOT NULL DEFAULT '',
        note_preview TEXT NOT NULL DEFAULT '',
        word_count INTEGER NOT NULL DEFAULT 0,
        character_count INTEGER NOT NULL DEFAULT 0,
        reading_time_min INTEGER NOT NULL DEFAULT 0,
        has_time_stamp INTEGER NOT NULL DEFAULT 0,
        is_auto_generated INTEGER NOT NULL DEFAULT 0
      )
    ''');

    await db.execute(
      '''
      CREATE TABLE note_tags (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        note_id INTEGER NOT NULL,
        tag TEXT NOT NULL,
        FOREIGN KEY(note_id) REFERENCES notes(id) ON DELETE CASCADE
      );
      '''
    );

  }


  

}