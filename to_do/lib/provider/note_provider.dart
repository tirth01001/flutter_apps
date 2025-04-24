


import 'package:flutter/widgets.dart';
import 'package:to_do/database/android_db.dart';
import 'package:to_do/models/take_note.dart';

class NoteProvider extends ChangeNotifier {

  TakeNote ? note;
  void initNote(TakeNote ? note){
    this.note = note;
    if(note != null){
      title.text = note.title;
      content.text = note.content;
      id = note.id;
      
    }
    notifyListeners();
  }


  void clearInit(){
    note = null;
    title.clear();
    content.clear();
    id = null;
    notifyListeners();
  }

  //Note Input
  final TextEditingController title = TextEditingController();
  final TextEditingController content = TextEditingController();



  int ? id; 
  void dataSaved(int id){
    this.id = id;
    notifyListeners();
  }



  void saveNotes() async {
    if(id != null){
      AndroidDB.instant.updateNotes(TakeNote(
        title: title.text, 
        content: content.text, 
        dateTime: DateTime.now(),
        id: id!
      ));
      print("Udapteing");
    }else{
      id = await AndroidDB.instant.createNote(TakeNote(
        title: title.text, 
        content: content.text, 
        dateTime: DateTime.now()
      ));
      print("Inseting");
    }
    notifyListeners();
  }



  void safeDeleteNote() async {
    if(note != null){
      AndroidDB.instant.deleteNote(note!);
    }else if(id != null){
      AndroidDB.instant.deleteNoteById(id!);
    }
    notifyListeners();
  }


}