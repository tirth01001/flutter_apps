


import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:notes/home/components/grid_notes_view.dart';
import 'package:notes/home/components/recent_view.dart';
import 'package:notes/home/components/tab_bar_view.dart';
import 'package:notes/screen/notes/note_input.dart';

class Home extends StatefulWidget {
  
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int bottomIndex =0;
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
        actions: [
          
        ],
      ),
      body: bottomIndex == 0 ? SingleChildScrollView(
        child: Column(
          children: [
            RecentView(),
            KTabBarView(),
            GridNotesView(),
          ],
        ),
      ):SizedBox(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
          Navigator.push(context, MaterialPageRoute(builder: (context) => NoteInput()));
        },
        shape: CircleBorder(),
        child: Center(child: Icon(IconlyLight.edit),),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        backgroundGradient: LinearGradient(colors: [
          Colors.orange.shade100,
          Colors.orangeAccent.shade100,
        ]),
        icons: [
          bottomIndex == 0 ? IconlyBold.document  : IconlyLight.document,
          bottomIndex == 1 ? IconlyBold.folder : IconlyLight.folder,
        ], 
        gapLocation: GapLocation.center,
        leftCornerRadius: 10,
        rightCornerRadius: 10,
        activeIndex: 0, 
        onTap: (p0) {
          
          if(bottomIndex != p0){
            setState(() {
              bottomIndex = p0;
            });
          }
      
        },
      )
    );
  }
}