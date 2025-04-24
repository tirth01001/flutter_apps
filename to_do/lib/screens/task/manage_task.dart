

import 'package:clean_calendar/clean_calendar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/animation/task_card_with_anime.dart';
import 'package:to_do/database/android_db.dart';
import 'package:to_do/main.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/provider/manage_task_provider.dart';
import 'package:to_do/widget/kapp_bar.dart';

class ManageTask extends StatelessWidget {

  final MangeTaskProvider provider;
  const ManageTask({super.key,required this.provider});

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider.value(
      value: provider,
      child: Scaffold(
        appBar: KappBar(
          strTitle: "Manage Task",
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
              
                Consumer<MangeTaskProvider>(
                  builder: (context,pvd,child) {

                    return Container(
                      width: maxW-40,
                      // height: 230,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: CleanCalendar(
                        enableDenseViewForDates: true,
                        enableDenseSplashForDates: true,
                        selectedDates: pvd.selectedDateTime,
                        dateSelectionMode: DatePickerSelectionMode.singleOrMultiple,
                        // selectedDatesProperties: DatesProperties(disable: false),
                        onSelectedDates: (value) {
                          // print(value);
                          pvd.updateList(value);
                        },
                      ),
                    );
                  }
                ),

                Consumer<MangeTaskProvider>(
                  builder: (context, value, child) {
                    
                    if(value.selectedDateTime.isEmpty){
                      return SizedBox();
                    }
                    
                    if(value.selectedDateTime.first.isAfter(DateTime.now())){
                      return SizedBox();
                    }

                    return Container(
                      constraints: BoxConstraints(
                        minHeight: 200
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20,),
                          Text("Task Planned On ${value.selectedDateTime.first.day}-${value.selectedDateTime.first.month}-${value.selectedDateTime.first.year}",style: TextStyle(
                            fontSize: 18,
                          ),),
                          const SizedBox(height: 20,),
                          FutureBuilder(
                            future: AndroidDB.instant.getTaskByDate(value.selectedDateTime.first), 
                            builder: (context, snapshot) {
                      
                              if(snapshot.connectionState == ConnectionState.waiting){
                                return Center(child: CircularProgressIndicator(),);
                              }
                              List<Task> snapDate = snapshot.data ?? [];

                              // if(snapDate.isEmpty){
                              //   return Container(
                              //     child: SvgPicture.asset("assets/error_img/no_task_2.svg"),
                              //   );
                              // }

                              return TaskCardWithAnime(
                                task: snapDate,
                                showAction: false,
                              );
                              
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
            

                // FutureBuilder(future: future, builder: builder)
                const SizedBox(height: 20,),
                Text("Upcoming Task",style: TextStyle(
                  fontSize: 18,
                ),),
                const SizedBox(height: 20,),
          
                FutureBuilder(
                  future: AndroidDB.instant.futureTaskList, 
                  builder: (context, snapshot) {

                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator(),);
                    }

                    List<Task> tasks = snapshot.data ?? [];

                    return TaskCardWithAnime(
                      task: tasks,
                      showAction: false,
                      errorImg: "assets/error_img/no_upcoming_task_found.svg",
                    );
                    
                  },
                )
                
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}