



import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do/database/android_db.dart';
import 'package:to_do/models/actions.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/models/task_summary.dart';
import 'package:to_do/widget/task_card.dart';

class TaskCardWithAnime extends StatefulWidget {

  final List<Task> task;
  final bool showAction;
  final String ? errorImg;
  const TaskCardWithAnime({super.key,this.task=const[],this.showAction=true,this.errorImg});

  @override
  State<TaskCardWithAnime> createState() => _TaskCardWithAnimeState();
}

class _TaskCardWithAnimeState extends State<TaskCardWithAnime> with SingleTickerProviderStateMixin {

  late Animation animation;
  late AnimationController animationController;

  final List<int> selectedIdx = [];

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this,duration: const Duration(milliseconds: 200));
    animation = Tween<double>(begin: 0.9,end: 0.0).animate(animationController);
  }

  TaskSummary ? summary;
  // PT -> PI = pending Task to In progress Task
  // PI -> CT = In Pogress Task To Complete Task
  // 
  // PT -> CT = pending Task TO Complete TAsk 
  // void updateSummaryStatus(String from,String to) async {
  //   TaskSummary summary = await AndroidDB.instant.todaySummary;
  //   if(summary.isNullSafe()){

  //   }
  // }

  // void updateTaskToProgress(int count) async {
  //   summary ??= await AndroidDB.instant.todaySummary;
  //   if(summary != null && summary!.isNullSafe()){
  //     print("Transferin");
  //     summary!.pendingTask = summary!.pendingTask! - count;
  //     summary!.progressTask = summary!.progressTask! + count;
  //     AndroidDB.instant.updateTaskState(summary!);
  //   }
  // }

  // void updateTaskToCompleted(int count) async {
  //   summary ??= await AndroidDB.instant.todaySummary;
  //   if(summary != null && summary!.isNullSafe()){
  //     // if(){}
  //     summary!.pendingTask = summary!.pendingTask! - count;
  //     summary!.completedTask = summary!.completedTask! + count;
  //     AndroidDB.instant.updateTaskState(summary!);
  //   }
  // }

  @override
  Widget build(BuildContext context) {

    if(widget.task.isEmpty){

      return Center(
        child: IntrinsicHeight(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset( widget.errorImg ?? "assets/error_img/no_task.svg",height: 200,),
              const SizedBox(height: 10,),
              Text("No Task Created !",style: TextStyle(
                fontSize: 14,
                color: Colors.grey
              ),)
            ],
          ),
        ),
      );
    }

    return Column(
      children: List.generate( selectedIdx.isNotEmpty ? widget.task.length+1: widget.task.length, (index){

        if(index == widget.task.length){

          return IntrinsicHeight(
            child: Row(
              children: [
                  
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: (){
                        setState(() {
                          List<int> ids = List.from(selectedIdx);
                          Set<int> removingIndex = Set.from(selectedIdx);
                          selectedIdx.clear();
                          widget.task.removeWhere((ele) => removingIndex.contains(ele.id) );
                          AndroidDB.instant.makeTaskComplete(ids);
                        });                
                      }, 
                      child: Text("Done")
                    ),
                  ),
                ),
                
              ],
            ),
          );
        }


        // if(widget.task[index].isCompleted){
        //   return SizedBox();
        // }

        // print(widget.task[index].id);

        return TaskCard(
          task: widget.task[index],
          showCheckBox: widget.showAction,
          checkBoxValue: selectedIdx.contains(widget.task[index].id),
          actions: CallBackActions(
            onChangeCheckBox: (value) {
              setState(() {
                if(selectedIdx.contains(widget.task[index].id)){
                  selectedIdx.remove(widget.task[index].id);
                }else{
                  if(widget.task[index].id != null) selectedIdx.add(widget.task[index].id!);
                }
              });
            },
          ),
        );

      }),
    );
  }
}