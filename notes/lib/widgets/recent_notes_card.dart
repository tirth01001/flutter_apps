

import 'package:flutter/material.dart';
import 'package:notes/model/notes.dart';
import 'package:notes/utils/responsive.dart';

class RecentNotesCard extends StatelessWidget {
  
  final NoteModel noteModel;
  const RecentNotesCard({super.key,required this.noteModel});

  String wrapString(String str){
    int max = Responsive.instant.handler.getMaxLenghtForWrapString();
    if(max < str.length){
      String newStr = "${str.substring(0,max)}...";
      return newStr;
    }
    return str;
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(top: 20,right: 20),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.2),
        // color: Colors.grey,
        borderRadius: BorderRadius.circular(8),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.red.withValues(alpha: 0.1),
        //     blurRadius: 10
        //   )
        // ]
      ),
      // height: 200,
      width: Responsive.instant.handler.getNotesCardWidth(),
      child: Text(noteModel.title,style: Theme.of(context).textTheme.headlineLarge,),
    );
  }
}