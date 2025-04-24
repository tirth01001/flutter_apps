


import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:to_do/provider/note_provider.dart';
import 'package:to_do/widget/kapp_bar.dart';

class NotesInput extends StatelessWidget {
  
  const NotesInput({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: KappBar(
        strTitle: "",
        showLeading: true,
        actions: [
          Consumer<NoteProvider>(
            builder: (context,pvd,child) {
    
              return IconButton(onPressed: () async {
              
                pvd.saveNotes();
                    
              }, icon: Icon(Icons.save));
            }
          ),
          IconButton(onPressed: (){
            context.read<NoteProvider>().safeDeleteNote();
            Navigator.pop(context);
          }, icon: Icon(IconlyLight.delete))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        
            Text("${DateTime.now()}",style: TextStyle(
              fontSize: 15,
              color: Colors.grey
            ),),
            const SizedBox(height: 10,),
            Consumer<NoteProvider>(
              builder: (context,pvd,child) {
                return TextField(
                  controller: pvd.title,
                  decoration: InputDecoration(
                    hintText: "Title...",
                    border: InputBorder.none,
                  ),
                );
              }
            ),
            // const SizedBox(height: 10,),
            const Divider(),
            // const SizedBox(height: 10,),
            Consumer<NoteProvider>(
              builder: (context,pvd,child) {
                return Expanded(
                  child: TextField(
                    maxLines: null,
                    expands: true,
                    controller: pvd.content,
                    decoration: InputDecoration(
                      hintText: "Write here...",
                      border: InputBorder.none,
                    ),
                  ),
                );
              }
            )
            
          ],
        ),
      ),
    );
  }
}