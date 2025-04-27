

import 'dart:io' as io;
import 'package:notes/model/category.dart';
import 'package:notes/model/notes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

class WindDb {
  static final WindDb instance = WindDb._internal();
  static Database? _database;

  WindDb._internal();

  Future<Database> get db async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    sqfliteFfiInit();
    final io.Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentsDir.path, "my_notes_windows.db");
    return await databaseFactoryFfi.openDatabase(
      dbPath,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: _onCreate,
      ),
    );
  }

  Future<void> _onCreate(Database db, int version) async {
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
      );
    ''');

    await db.execute('''
      CREATE TABLE note_tags (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        note_id INTEGER NOT NULL,
        tag TEXT NOT NULL
        --FOREIGN KEY(note_id) REFERENCES notes(id) ON DELETE CASCADE
      );
    ''');


    await db.execute('''
      CREATE TABLE recent_view (
        note_id INTEGER PRIMARY KEY
        -- id INTEGER PRIMARY KEY AUTOINCREMENT,
      );
    ''');

    await db.insert('note_tags', {
      'note_id': -1,
      'tag': 'all'
    });

  }

  void insertRecord(NoteModel notes) async {
    if(notes.id != null){
      updateRecord(notes);
      return;
    }
    final dbs = await db;
    await dbs.insert("notes", notes.toSqlFieldMap);
  }


  void insertCategory(Category category) async {
    if(category.id != -1){
      updateCategory(category);
      return;
    }
    final dbs = await db;
    await dbs.insert('note_tags', category.toSqliteMap());
  }

  Future<List<NoteModel>> get notes async {
    final dbs = await db;
    List<Map<String,dynamic>> data = await dbs.query('notes');
    return List.generate(data.length, (index) => NoteModel.fromSqlFieldMap(data[index]));
  }

  Future<List<Category>> get noteTypes async {
    final dbs = await db;
    print("Callingg");
    List<Map<String,dynamic>> data = await dbs.query('note_tags');
    return List.generate(data.length, (index) => Category.fromSqliteMap(data[index]));
  }

  void updateRecord(NoteModel note) async {

    final dbs = await db;
    await dbs.update('notes', note.toSqlFieldMap,where: 'id = ? ',whereArgs: [note.id]);
  }

  void updateCategory(Category noteType) async {
    final dbs = await db;
    await dbs.update('note_tags', noteType.toSqliteMap());
  }


  void deleteNotes(NoteModel model) async {
    if(model.id != null){
      final dbs = await db;
      await dbs.delete('notes',where: "id = ?",whereArgs: [model.id]);
    }
  }


  Future<List<NoteModel>> getNoteByCategoyr(String category) async {
    final dbs = await db;
    List<Map<String,dynamic>> noteByCategoyr = await dbs.query(
      'notes',
      where: "note_type = ?",
      whereArgs: [category.toLowerCase()]
    );
    return List.generate(noteByCategoyr.length, (i)=> NoteModel.fromSqlFieldMap(noteByCategoyr[i]));
  }

  //Manage Recent View

  void insertRecentView(int noteId) async {
    final dbs = await db;
    await dbs.insert('recent_view', {
      'note_id': noteId,
    },conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<int>> get recentIds async {
    final dbs = await db;
    List<Map<String,dynamic>> result = await dbs.query('recent_view');
    return List.generate(result.length, (index) => result[index]["note_id"]);
  }

}
