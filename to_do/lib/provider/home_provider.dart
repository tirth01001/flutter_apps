

import 'package:flutter/material.dart';
import 'package:to_do/database/android_db.dart';
import 'package:to_do/home/function.dart';
import 'package:to_do/models/task.dart';

class HomeProvider extends ChangeNotifier {

  //Bool Partion
  List<Task> completedTask = [];
  List<Task> inCompletedTask = [];


  void savePartition(List<Task> task){
    List<List<Task>> partition = boolPartion(task);
    completedTask = partition[0];
    inCompletedTask = partition[1];
    // notifyListeners();
  }

  //Bottom Navigation Bar Config
  int bottomIndex = 0;
  set bottomIDX(int idx) {
    bottomIndex = idx;
    notifyListeners(); 
  }

  void preLoadDate() async {
    List<Task> data = await AndroidDB.instant.todayTask;
    savePartition(data);
    print(completedTask);
    notifyListeners();
  }

  void update() => notifyListeners();
}