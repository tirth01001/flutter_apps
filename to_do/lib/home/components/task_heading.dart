


import 'package:flutter/material.dart';
import 'package:to_do/widget/task_card.dart';

class TaskHeading extends StatelessWidget {

  const TaskHeading({super.key});

  @override
  Widget build(BuildContext context) {
 
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Today's Task ",style: TextStyle(
            fontSize: 16,
          ),),
          const SizedBox(height: 20,),
          TaskCard(),
          TaskCard(),
          TaskCard(),
        ],
      ),
    );
  }
}



