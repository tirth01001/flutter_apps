



import 'package:flutter/material.dart';

class TaskCreativeProvider extends ChangeNotifier {

  final TextEditingController title = TextEditingController();
  final TextEditingController titleDescr = TextEditingController();
  final TextEditingController date = TextEditingController();
  final TextEditingController timeDay = TextEditingController();

  String priority = "top";
  DateTime ? taskDate;
  TimeOfDay ? taskTime;

  void changeDate(DateTime ? dt,{TimeOfDay ? time}){
    taskDate = dt ?? taskDate;
    taskTime = time ??  taskTime;
    if(dt != null) date.text = "${dt.day}/${dt.month}/${dt.year}";
    if(time != null) timeDay.text = "${time.hour}:${time.minute} ${time.hour < 12 ? "AM" : "PM"}";
    notifyListeners();
  }

  void changePriority(String value){
    priority  = value;
    notifyListeners();
  }

}