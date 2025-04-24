


import 'package:flutter/material.dart';

class Task {

  int ? id;
  String taskName;
  String taskDetail;
  String strDate; 
  DateTime dueDate;
  String strTime;
  TimeOfDay dueTime;
  int priority;
  bool isCompleted;

  Task({
    this.id,
    required this.dueDate,
    required this.priority,
    required this.strDate,
    required this.taskDetail,
    required this.taskName,
    required this.dueTime,
    required this.strTime,
    required this.isCompleted
  });

  


}