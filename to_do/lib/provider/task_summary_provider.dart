



import 'package:flutter/material.dart';
import 'package:to_do/database/android_db.dart';
import 'package:to_do/models/task_summary.dart';

class TaskSummaryProvider extends ChangeNotifier {

  TaskSummary currantSummary = TaskSummary();

  void initSummary() async {
    currantSummary = await AndroidDB.instant.todaySummary;
    notifyListeners();
  }

  void reInit(){
    initSummary();
    notifyListeners();
  }

}