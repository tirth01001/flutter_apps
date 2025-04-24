


import 'dart:async';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:to_do/animation/task_card_with_anime.dart';
import 'package:to_do/database/android_db.dart';
import 'package:to_do/provider/home_provider.dart';
import 'package:to_do/provider/manage_task_provider.dart';
import 'package:to_do/provider/note_provider.dart';
import 'package:to_do/provider/task_creative_provider.dart';
import 'package:to_do/screens/create/task_create.dart';
import 'package:to_do/screens/notes/components/notes_input.dart';
import 'package:to_do/screens/notes/notes_screen.dart';
import 'package:to_do/screens/setting/setting.dart';
import 'package:to_do/screens/task/manage_task.dart';
import 'package:to_do/widget/kapp_bar.dart';
import 'package:to_do/widget/task_card.dart';
 
class Home extends StatelessWidget {

  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    
    final provider = Provider.of<HomeProvider>(context);

    return Scaffold(
      appBar: provider.bottomIndex == 0 ?  KappBar(
        strTitle: "Quick Do",
      ) : null,
      body: Consumer<HomeProvider>(
        builder: (context,provider,child) {
          

          if(provider.bottomIndex == 1){

            return ManageTask(
              provider: MangeTaskProvider(),
            );
          }

          if(provider.bottomIndex == 2){
            
            // return TaskChart(
            //   provider: TaskSummaryProvider(),
            // );
            return NotesScreen();
          }

          if(provider.bottomIndex == 3){

            return Setting();
          }


          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10,),
                  Text("Today's Task",style: TextStyle(
                    fontSize: 17
                  ),),
                  const SizedBox(height: 10,),
                  FutureBuilder(
                    future: AndroidDB.instant.todayTask, 
                    builder: (context, snapshot) {
                  
                      if(!snapshot.hasData && AndroidDB.instant.db == null){
                        Timer(const Duration(seconds: 1), (){
                          provider.update();
                        });      
                        return Center(child: CircularProgressIndicator(),);
                      }
            

                      provider.savePartition(snapshot.data??[]);
                      // List<Task> snaps = boolPartion(snapshot.data??[])[1];
                      // print(snaps);

                      return TaskCardWithAnime(
                        task: provider.inCompletedTask,
                        errorImg: "assets/error_img/no_task_3.svg",
                      );
                    },
                  ),

                  //Show Incompleted Tas
                  //
                  //
                  const SizedBox(height: 20,),
                  if(provider.completedTask.isNotEmpty)
                  Text("Completed Task",style: TextStyle(
                    fontSize: 17
                  ),),
                  if(provider.completedTask.isNotEmpty)
                    ...provider.completedTask.map((value){

                    return TaskCard(
                      task: value,
                      showCheckBox: false,
                    );
                  }),


                  const SizedBox(height: 30,),
                ],
              ),
            ),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

          if(provider.bottomIndex == 2){
            context.read<NoteProvider>().clearInit();
            Navigator.push(context, MaterialPageRoute(builder: (context) => NotesInput()));
            return;
          }

          Navigator.push(context, MaterialPageRoute(builder: (context) => TaskCreate(provider: TaskCreativeProvider(),)));
        },
        shape: CircleBorder(),
        child: provider.bottomIndex == 2 ? Icon(IconlyLight.plus) :  Icon(IconlyLight.activity),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Consumer<HomeProvider>(
        builder: (context,provider,child) {

          return AnimatedBottomNavigationBar(
            icons: [
              provider.bottomIndex == 0 ? IconlyBold.home : IconlyLight.home,
              provider.bottomIndex == 1 ? IconlyBold.calendar  : IconlyLight.calendar,
              provider.bottomIndex == 2 ? IconlyBold.document :  IconlyLight.document,
              provider.bottomIndex == 3 ? IconlyBold.setting : IconlyLight.setting,
            ], 
            gapLocation: GapLocation.center,
            leftCornerRadius: 20,
            rightCornerRadius: 20,
            activeIndex: provider.bottomIndex,
            elevation: 20,
            // backgroundGradient: LinearGradient(colors: [
            //   // Colors.orange.shade100,
            //   // Colors.orange.shade200,
            //   // Colors.orangeAccent,
            // ]),
            onTap: (idx) {
              provider.bottomIDX = idx;
            },
          );
        }
      ),
    );
  }
}