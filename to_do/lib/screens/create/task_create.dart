


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/database/android_db.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/provider/home_provider.dart';
import 'package:to_do/provider/task_creative_provider.dart';
import 'package:to_do/widget/kapp_bar.dart';
import 'package:to_do/widget/kinput.dart';

class TaskCreate extends StatelessWidget {
  
  final TaskCreativeProvider provider;
  const TaskCreate({super.key,required this.provider});

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => provider,
      child: Scaffold(
        appBar: KappBar(
          strTitle: "Create Task",
          showLeading: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            
                Text("Task Title",style: TextStyle(
                  fontSize: 17,
                ),),
                
                KInput(
                  controller: provider.title,
                  hint: "Task Name",
                ),
                
                const SizedBox(height: 20,),
                Text("Task Detail",style: TextStyle(
                  fontSize: 17,
                ),),
                
                KInput(
                  controller: provider.titleDescr,
                  hint: "Description",
                  maxLine: 5,
                ),
                
                
                const SizedBox(height: 20,),
                Text("Due Date",style: TextStyle(
                  fontSize: 17,
                ),),
                
                Consumer<TaskCreativeProvider>(
                  builder: (context,pvd,child) {
          
                    return KInput(
                      controller: pvd.date,
                      hint: "Date",
                      tralling: IconButton(
                        onPressed: () async {
          
                          DateTime ? time = await showDatePicker(
                            context: context, 
                            firstDate: DateTime(2000), 
                            lastDate: DateTime(3000),
                          );
          
                          pvd.changeDate(time);
          
                        }, 
                        icon: Icon(Icons.date_range)
                      ),
                    );
                  }
                ),
          
          
          
          
                //Time 
                const SizedBox(height: 20,),
                Text("Due Time",style: TextStyle(
                  fontSize: 17,
                ),),
                
                Consumer<TaskCreativeProvider>(
                  builder: (context,pvd,child) {
          
                    return KInput(
                      controller: pvd.timeDay,
                      hint: "Time",
                      tralling: IconButton(
                        onPressed: () async {
          
                          TimeOfDay ? time = await showTimePicker(
                            context: context, 
                            initialTime: TimeOfDay.now()
                          );
          
                          pvd.changeDate(null,time: time);
          
                        }, 
                        icon: Icon(Icons.date_range)
                      ),
                    );
                  }
                ),
                
                const SizedBox(height: 20,),
                Text("Task Priority",style: TextStyle(
                  fontSize: 17,
                ),),
                
                Consumer<TaskCreativeProvider>(
                  builder: (context,pvd,child) {
                    return Row(
                      children: [
                        Radio(value: "top", groupValue: provider.priority, onChanged: (value){
                          pvd.changePriority(value??"top");
                        }),
                        Radio(value: "mid", groupValue: provider.priority, onChanged: (value){
                          pvd.changePriority(value??"top");
                        }),
                        Radio(value: "low", groupValue: provider.priority, onChanged: (value){
                          pvd.changePriority(value??"top");
                        }),
                      ],
                    );
                  }
                ),
                
                ElevatedButton(onPressed: (){
                  
                  AndroidDB.instant.createTask(Task(
                    isCompleted: false,
                    dueTime: provider.taskTime ?? TimeOfDay.now(),
                    strTime: provider.timeDay.text,
                    dueDate: provider.taskDate??DateTime.now(), 
                    priority: provider.priority == "top" ? 0 : provider.priority =="mid" ? 1  : 2, 
                    strDate: provider.date.text, 
                    taskDetail: provider.titleDescr.text, 
                    taskName: provider.title.text
                  ));
          
                  context.read<HomeProvider>().preLoadDate();
          
                }, child: Text("Save")),
                const SizedBox(height: 20,),
                ElevatedButton(onPressed: (){}, child: Text("Cancel")),
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}