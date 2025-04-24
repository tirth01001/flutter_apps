


import 'package:to_do/models/task.dart';

List<List<Task>> boolPartion(List<Task> task) {
  List<Task> completed = [];
  List<Task> nonCompleted = [];
  for(var item in task){
    if(item.isCompleted){
      completed.add(item);
    }else{
      nonCompleted.add(item); 
    }
  }
  return [completed,nonCompleted];
}