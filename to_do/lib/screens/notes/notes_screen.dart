

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/database/android_db.dart';
import 'package:to_do/models/actions.dart';
import 'package:to_do/models/take_note.dart';
import 'package:to_do/provider/note_provider.dart';
import 'package:to_do/screens/notes/components/notes_input.dart';
import 'package:to_do/widget/kapp_bar.dart';
import 'package:to_do/widget/notes_card.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: KappBar(
        strTitle: "Notes",
      ),
      body: Consumer<NoteProvider>(
        builder: (context,provider,child) {

          return FutureBuilder(
            future: AndroidDB.instant.notesList, 
            builder: (context, snapshot) {
              
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }
          
              if(snapshot.hasError){
                return Text(snapshot.error.toString());
              }
          
              List<TakeNote> note = snapshot.data ?? [];
          
              return ListView.builder(
                itemBuilder: (context, index) {
                  
                  return NotesCard(
                    title: note[index].title,
                    content: note[index].content,
                    actions: CallBackActions(
                      onTap: (){

                        provider.initNote(note[index]);

                        Navigator.push(context, MaterialPageRoute(builder: (context)=> NotesInput()));
                      }
                    ),
                  );
                },
                itemCount: note.length,
              );
            },
          );
        }
      ),
    );
  }
}