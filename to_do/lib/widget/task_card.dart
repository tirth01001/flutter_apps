
// [✅]  Doctor Appointment                    🔴 High
//       Visit Dr. Mehta for checkup      🗓️ Today, 5:00 PM  
//       #Personal                         🔔  


import 'package:flutter/material.dart';
import 'package:to_do/models/actions.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/widget/tag_view.dart';

class TaskCard extends StatelessWidget {
  
  final Task ? task;
  final double animeOpecity;
  final bool checkBoxValue;
  final CallBackActions ? actions;
  final bool showCheckBox;
  const TaskCard({
    super.key,
    this.task,
    this.animeOpecity=1,
    this.checkBoxValue=false,
    this.actions,
    this.showCheckBox=true,
  });

  @override
  Widget build(BuildContext context) {

    return Opacity(
      opacity: animeOpecity,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0,vertical: 10),
        decoration: BoxDecoration(
          // color: Colors.grey.shade200,
          gradient: LinearGradient(colors: [
            Colors.grey.shade100,
            Colors.grey.shade200,
          ]),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10
            )
          ]
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(showCheckBox) Checkbox(
                    value: checkBoxValue, 
                    onChanged: actions?.onChangeCheckBox
                  ),
                  const SizedBox(width: 20,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(task?.taskName ?? "Doctor Appointment",style: TextStyle(
                          fontWeight: FontWeight.w500
                        ),),
                        Text(task?.taskDetail ?? "Visit Dr. Mehta for Checkup",style: TextStyle(),),
                        // Chip(label: Text("Personal")),
                      ],
                    ),
                  ),
                  // const SizedBox(width: 30,),
                  // Expanded(child: Container()),
                  IntrinsicHeight(
                    child: IntrinsicWidth(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if(task?.priority != null) 
                            Text(task!.priority == 0 ? "High" : task!.priority == 1 ? "Medium" : "Low")
                          else Text("Hight"),
                          Text(task?.strDate ?? "Today, 5:00 PM"),
                          // Chip(label: Text("Personal")),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      
              const SizedBox(height: 20,),
      
              Wrap(
                children: [
                  TagView(text: "Time")
                ],
              )
      
            ],
          ),
        ),
      ),
    );
  }
}