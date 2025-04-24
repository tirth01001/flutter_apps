import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:to_do/models/take_note.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/models/task_summary.dart';


class AndroidDB {

  static AndroidDB instant = AndroidDB();

  Database ? db;

  Future<void> initDB() async {
  try {
    final directory = await getDatabasesPath();
    final dbPath = p.join(directory, "myDb.db");

    db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS TASK (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT,
              descr TEXT,
              due_date TEXT,
              due_time TEXT,
              formate_date TEXT,
              formate_time TEXT,
              priority INTEGER,
              is_completed INTEGER DEFAULT 0, 
              category TEXT,
              created_at TEXT 
          )
        ''');

          await db.execute(''' 
            CREATE TABLE IF NOT EXISTS TASK_SUMMARY (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              task_date TEXT,
              total_task INTEGER,
              completed_task INTEGER,
              pending_task INTEGER,
              progress_task INTEGER,
              overdue_task INTEGER
            )
          ''');

          await db.execute(''' 
            CREATE TABLE IF NOT EXISTS NOTES (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT,
              content TEXT,
              create_at TEXT DEFAULT CURRENT_TIMESTAMP
            )
          ''');

          // await db.execute('''
          //   CREATE VIRTUAL TABLE IF NOT EXISTS notes_fts USING fts5(title,content)
          // ''');
        },
      );

      debugPrint("SQLite DB initialized on Android!");
    } catch (e) {
      debugPrint("Error initializing DB: $e");
    }
  }


  //Give Specific Record OF Task
  Future<Map<String,dynamic>> getSpecificTaskSummary(DateTime date) async {
    if(db == null){
      debugPrint('Database is not initialized.');
      return {};
    }
    String pureDate = getSpiltedDate(date);
    List<Map<String,dynamic>> specificRecord = await db!.query( 
      'TASK_SUMMARY',
      where: "task_date LIKE ?",
      whereArgs: ["$pureDate%"]
    );
    if(specificRecord.isEmpty) {
      return {};
    }
    return specificRecord.first;
  }

  // Ensure the database is initialized before performing actions
  // completed_task INTEGER,
  // pending_task INITEGER,
  // progress_task INTEGER,
  // overdue_task INTEGER
  Future<void> createTask(Task task) async {
    if (db == null) {
      debugPrint('Database is not initialized.');
      return;
    }
    // debugPrint( task.dueDate.toIso8601String());
    Map<String,dynamic> summaryData = await getSpecificTaskSummary(task.dueDate);
    // debugPrint(summaryData);
    if(summaryData.isNotEmpty){
      await db!.update('TASK_SUMMARY', {
        'total_task': summaryData["total_task"]+1,
        'pending_task': summaryData['pending_task']+1,
      },conflictAlgorithm: ConflictAlgorithm.replace);
    }else{
      await db!.insert('TASK_SUMMARY', {
        'total_task': 1,
        'task_date': task.dueDate.toIso8601String(),
        'completed_task': 0,
        'pending_task': 1,
        'progress_task': 0,
        'overdue_task':0
      },conflictAlgorithm: ConflictAlgorithm.replace);
    }

    await db!.insert("TASK", {
      'title': task.taskName,
      'descr': task.taskDetail,
      'due_date': task.dueDate.toIso8601String(),
      'formate_date': task.strDate,
      'due_time': "${task.dueTime.hour}:${task.dueTime.minute}",
      'formate_time': task.strTime,
      'priority': task.priority,
    });
  }

  //Parse Time
  TimeOfDay parseTimeOfDay(String timeStr) {
    final parts = timeStr.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }

  // Ensure the database is initialized before fetching data
  Future<List<Task>> get tasklist async {
    if (db == null) {
      debugPrint('Database is not initialized.');
      return [];
    }

    List<Map<String, dynamic>> list = await db!.query('TASK');
    return List.generate(list.length, (index) {
      return Task(
        id: list[index]["id"],
        isCompleted: list[index]['is_completed']== 0 ? false : true,
        dueTime: parseTimeOfDay(list[index]["due_time"]),
        strTime: list[index]["formate_time"],
        dueDate: DateTime.parse(list[index]["due_date"]),
        priority: list[index]["priority"],
        strDate: list[index]["formate_date"],
        taskDetail: list[index]["descr"],
        taskName: list[index]["title"],
      );
    });
  }

  String getTodayDate() {
    final DateTime dateTime = DateTime.now();
    return dateTime.toIso8601String().split("T").first;
  }

  String getSpiltedDate(DateTime date) => date.toIso8601String().split("T").first;

  Future<List<Task>> get todayTask async {
    if(db == null){
      debugPrint("Database is not inited. ");
      return [];
    }

    String todayDate = getTodayDate();
    debugPrint(todayDate);
    List<Map<String,dynamic>> tasks = await db!.query(
      'TASK',
      where: 'due_date LIKE ?',
      whereArgs: ["$todayDate%"]
    );

    // print(tasks);

    return List.generate(tasks.length, (index){
      return Task(
        id: tasks[index]["id"],
        isCompleted: tasks[index]['is_completed']== 0 ? false : true,
        dueTime: parseTimeOfDay(tasks[index]["due_time"]),
        strTime: tasks[index]["formate_time"],
        dueDate: DateTime.parse(tasks[index]["due_date"]), 
        priority: tasks[index]["priority"], 
        strDate: tasks[index]["formate_date"], 
        taskDetail: tasks[index]["descr"], 
        taskName: tasks[index]["title"]
      );
    });
  }


  Future<List<Task>> getTaskByDate(DateTime date) async {
    if(db == null){
      debugPrint("Database is not inited. ");
      return [];
    }

    String specificDate = getSpiltedDate(date);
    List<Map<String,dynamic>> tasks = await db!.query(
      'TASK',
      where: 'due_date LIKE ?',
      whereArgs: ["$specificDate%"]
    );

    return List.generate(tasks.length, (index){
      return Task(
        id: tasks[index]["id"],
        isCompleted: tasks[index]['is_completed']== 0 ? false : true,
        dueTime: parseTimeOfDay(tasks[index]["due_time"]),
        strTime: tasks[index]["formate_time"],
        dueDate: DateTime.parse(tasks[index]["due_date"]), 
        priority: tasks[index]["priority"], 
        strDate: tasks[index]["formate_date"], 
        taskDetail: tasks[index]["descr"], 
        taskName: tasks[index]["title"]
      );
    });
  }


  Future<List<Task>> get futureTaskList async {
    if(db == null){
      debugPrint("Database is not inited. ");
      return [];
    }

    String specificDate = getTodayDate();
    List<Map<String,dynamic>> tasks = await db!.query(
      'TASK',
      where: 'due_date > ?',
      whereArgs: [specificDate]
    );

    return List.generate(tasks.length, (index){
      return Task(
        id: tasks[index]["id"],
        isCompleted: tasks[index]['is_completed'] == 0 ? false : true,
        dueTime: parseTimeOfDay(tasks[index]["due_time"]),
        strTime: tasks[index]["formate_time"],
        dueDate: DateTime.parse(tasks[index]["due_date"]), 
        priority: tasks[index]["priority"], 
        strDate: tasks[index]["formate_date"], 
        taskDetail: tasks[index]["descr"], 
        taskName: tasks[index]["title"]
      );
    });
  }


  void makeTaskComplete(List<int> idsList) async {
    if(db == null){
      debugPrint("DataBase not inited !");
      return;
    }
    // String temp = "( ${List.filled(idsList.length, '?').join(',')} )";
    await db!.update('TASK', {
      'is_completed': 1,
      },
      where: "id IN ( ${List.filled(idsList.length, '?').join(',')} )",
      whereArgs: idsList
    );
    // print(temp);
  }



  Future<TaskSummary> get todaySummary async {

    if(db == null){
      debugPrint("Data Base not inited !");
      return TaskSummary();
    }

    List<Map<String,dynamic>> summary = await db!.query(
      'TASK_SUMMARY',
      where: "task_date LIKE ?",
      whereArgs: ["${getTodayDate()}%"]
    );

    // debugPrint(summary);

    if(summary.isEmpty){
      return TaskSummary();
    }
    return TaskSummary.fromSqlite(summary.first);
    // return List.generate(summary.length, (index) => TaskSummary.fromSqlite(summary[index]));
  }


  void updateTaskState(TaskSummary summary) async {
    if(summary.isNullSafe()){
      if(db == null){
        debugPrint("Db not inited ");
        return;
      }
      await db!.update(
        'TASK_SUMMARY',
        summary.toSqlField(),
        where: 'id = ?',
        whereArgs: [summary.id]
      );
    }
  }



  Future<int> createNote(TakeNote note) async {
    if(db == null){
      debugPrint("Database not initlized !");
      return -1;
    }
    await db!.insert('NOTES', note.toSqlFieldWithoutID);
    List<Map<String,dynamic>> data =  await db!.query('NOTES');
    return data.last["id"];
  }


  void updateNotes(TakeNote note) async {
    if(db == null){
      debugPrint("Database inited !");
      return;
    }
    await db!.update(
      'NOTES', 
      note.toSqlField,
      where: " id = ?",
      whereArgs: [note.id]
    );
  }


  Future<List<TakeNote>>  get notesList  async {
    if(db == null){
      debugPrint("Database not initilized !");
      return [];
    }
    List<Map<String,dynamic>> data = await db!.query('NOTES');
    // print(data);
    return List.generate(data.length, (index) => TakeNote.fromSQl(data[index]));
  }


  void deleteNote(TakeNote note) async {
    if(db == null){
      debugPrint("Database not initilized !");
      return;
    }
    await db!.delete('NOTES',where: 'id = ?',whereArgs: [note.id]);
  }

  void deleteNoteById(int id) async {
    if(db == null){
      debugPrint("Database not initilized !");
      return;
    }
    await db!.delete('NOTES',where: 'id = ?',whereArgs: [id]);
  }

}