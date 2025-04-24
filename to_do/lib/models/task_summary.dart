

class TaskSummary {

  int ? id ;
  String ? taskDate ;  // Date Of That Task
  int ? totalTask ;  // Total Task of that
  int ? completedTask ; // count of complete Task
  int ? pendingTask ; // count of Pending Task
  int ? progressTask ;  // Count of progress Task
  int ? overdueTask ; // Count of Overdue Task


  TaskSummary({
    this.completedTask,
    this.id,
    this.overdueTask,
    this.pendingTask,
    this.progressTask,
    this.taskDate,
    this.totalTask,
  });


  factory TaskSummary.fromSqlite(Map<String,dynamic> data){
    return TaskSummary(
      id: data["id"],
      taskDate: data["task_date"],
      totalTask: data["total_task"],
      completedTask: data["completed_task"],
      pendingTask: data["pending_task"],
      progressTask: data["progress_task"],
      overdueTask: data["overdue_task"]
    );
  }

  Map<String,dynamic> toSqlField() => {
    'id': id,
    'task_date': taskDate,
    'completed_task': completedTask,
    'pending_task': pendingTask,
    'progress_task': progressTask,
    'overdue_task': overdueTask
  };

  bool isNullSafe() => (id != null && taskDate != null && totalTask != null && completedTask != null && pendingTask != null
    && progressTask != null && overdueTask != null
  );

}