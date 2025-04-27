
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:iconly/iconly.dart';
import 'package:notes/bloc/home/home_bloc.dart';
import 'package:notes/database/wind_db.dart';
import 'package:notes/model/notes.dart';

class NoteInput extends StatefulWidget {

  final NoteModel  ? noteModel;
  const NoteInput({super.key,this.noteModel});

  @override
  State<NoteInput> createState() => _NoteInputState();
}

class _NoteInputState extends State<NoteInput> {

  // final QuillController _controller = QuillController.basic();
  late QuillController _controller;
  final TextEditingController _title = TextEditingController();
  final TextEditingController _category = TextEditingController();
  bool _showBOTTOM = false;
  final GlobalKey _globalKey = GlobalKey();
  NoteModel ? noteModel;


  @override
  void initState() {
    super.initState();
    if(widget.noteModel != null){
      _controller = QuillController(
        document: Document.fromDelta(
          Delta.fromJson(List<Map<String,dynamic>>.from(jsonDecode(widget.noteModel!.content))),
        ),
        selection: TextSelection.collapsed(offset: 0),
      );
      _title.text = widget.noteModel!.title;
      noteModel = widget.noteModel;
    }else{
      _controller = QuillController.basic();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Untitle'),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(IconlyLight.arrow_left_2)),
        actions: [
          IconButton(
            key: _globalKey,
            onPressed: (){

              RenderBox box = _globalKey.currentContext?.findRenderObject() as RenderBox;
              Offset offset = box.localToGlobal(Offset.zero);
              Size size = box.size;

              showMenu(
                context: context, 
                position: RelativeRect.fromLTRB(
                  offset.dx, 
                  offset.dy, 
                  offset.dx  + size.width,
                  offset.dy  + size.height
                ),
                items: [
                  PopupMenuItem(
                    onTap: () {


                    
                      noteModel = NoteModel(
                        id: widget.noteModel?.id,
                        title: _title.text, 
                        content: jsonEncode(_controller.document.toDelta().toJson()), 
                        createdAt: widget.noteModel?.createdAt ?? DateTime.now(), 
                        updatedAt: DateTime.now(),
                        noteType: _category.text.toLowerCase()
                      );

                      // print(noteModel!.toSqlFieldMap);
                      WindDb.instance.insertRecord(noteModel!);
                      context.read<HomeBloc>().add(ReloadEvent());

                      // Future(()async {
                      //   List<NoteModel> model = await WindDb.instance.notes;
                      //   print(model.first.toSqlFieldMap);
                      // });


                    },
                    child: Row(children: [
                      Icon(Icons.save),
                      const SizedBox(width: 10,),
                      Text("Save Note")],
                    ),
                  ),
                  PopupMenuItem(
                    child: Row(children: [
                      Icon(Icons.settings),
                      const SizedBox(width: 10,),
                      Text("Setting")],
                    ),
                  ),
                  PopupMenuItem(
                    child: Row(children: [
                      Icon(Icons.edit),
                      const SizedBox(width: 10,),
                      Text("About Editor")],
                    ),
                  ),
                ]
              );

            }, 
            icon: Icon(IconlyLight.more_circle)
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _title,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Note title",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400
                      )
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _category,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Note Category",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400
                      )
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey.shade300,indent: 20,endIndent: 20,),
          Expanded(
            child: QuillEditor(
              focusNode: FocusNode(), 
              scrollController: ScrollController(), 
              controller: _controller,
              config: QuillEditorConfig(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                placeholder: "Write here.....",
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showBOTTOM = !_showBOTTOM;
          setState(() {});
        },
        child: Center(
          child: _showBOTTOM ? Icon(IconlyLight.arrow_down_2)  : Icon(IconlyLight.arrow_up_2),
        ),
      ),
      bottomSheet: _showBOTTOM ?  BottomSheet(
        onClosing: (){}, 
        builder: (context) {
          
          return Padding(
            padding: const EdgeInsets.only(top: 30),
            child: QuillSimpleToolbar(
              controller:_controller,
            ),
          );
        },
      ) : null,
    );
  }
}