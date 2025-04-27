


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:iconly/iconly.dart';
import 'package:notes/bloc/home/home_bloc.dart';
import 'package:notes/database/wind_db.dart';
import 'package:notes/model/notes.dart';
import 'package:notes/screen/notes/note_input.dart';
import 'package:notes/widgets/note_tool_button.dart';

class NotesViewCard extends StatefulWidget {
  
  final NoteModel ? model;
  // final VoidCallback ? onTap;
  const NotesViewCard({super.key,this.model});

  @override
  State<NotesViewCard> createState() => _NotesViewCardState();
}

class _NotesViewCardState extends State<NotesViewCard> with SingleTickerProviderStateMixin {

  late Animation _animation;
  late AnimationController _animationController;

  late QuillController _quillController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this,duration: const Duration(milliseconds: 300));
    _animation = Tween<double>(begin: 0.0,end: 1.0).animate(_animationController);
    
    if(widget.model != null){
      _quillController = QuillController(
        readOnly: true,
        document: Document.fromDelta(
          Delta.fromJson(List<Map<String,dynamic>>.from(jsonDecode(widget.model!.content)))
        ),
        selection: TextSelection.collapsed(offset: 0)
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(
      animation: _animation,
      builder: (context,child) {

        // print(_animation.value);


        return Container(
          margin: const EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
            color: Colors.grey.withValues(alpha: .3),
            borderRadius: BorderRadius.circular(8)
          ),
          constraints: BoxConstraints(
            minHeight: 150
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Stack(
            children: [
        
              GestureDetector(
                onTap: () {
                  
                  WindDb.instance.insertRecentView(widget.model!.id!);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NoteInput(
                    noteModel: widget.model,
                  )));

                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.model != null ? widget.model!.title : "Note Title"),
                        IconButton(onPressed: (){
                          _animationController.forward();
                          // if(_animation.isForwardOrCompleted){
                          //   _animationController.reverse();
                          // }
                        }, icon: Icon(IconlyLight.more_square))
                      ],
                    ),
                    const Divider(color: Colors.grey,indent: 0,endIndent: 0,),
                    
                    // Text(widget.model != null ? widget.model!.content : "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries",style: Theme.of(context).textTheme.bodySmall,)
                    if(widget.model != null)
                      QuillEditor.basic(
                        controller: _quillController,
                        focusNode: FocusNode(canRequestFocus: false),
                        config: QuillEditorConfig(
                          enableInteractiveSelection: false
                        ),
                      )
                  ],
                ),
              ),
        
        
              if(_animation.value != 0.0) Positioned.fill(
                child: AnimatedOpacity(
                  opacity: _animation.value,
                  // opacity: 1,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    decoration: BoxDecoration(
                      // color: Colors.grey,
                      color: Colors.grey.withValues(alpha: .1),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.7),
                          blurRadius: 20,
                          spreadRadius: 3
                        )
                      ]
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(),
                            IconButton(onPressed: (){
                              _animationController.reverse();
                            }, icon: Icon(IconlyLight.close_square))
                          ],
                        ),
                        // const SizedBox(height: 20,),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [


                            NoteToolButton(
                              icon: Icon(IconlyLight.edit),
                            ),
                            
                            
                            NoteToolButton(
                              icon: Icon(IconlyLight.delete),
                              onTap: (){
                                
                                if(widget.model != null) WindDb.instance.deleteNotes(widget.model!);
                                context.read<HomeBloc>().add(ReloadEvent());
                              },
                            ),
                            
                                                  
                            NoteToolButton(
                              icon: Icon(IconlyLight.lock),
                            ),


                          ],
                        ),
        
                      ],
                    ),
                  ),
                ),
              )
        
          
        
            ],
          ),
        );
      }
    );
  }
}









class HalfCirculeClip extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
     final paint = Paint()
      ..color = Colors.grey.shade200
      ..style = PaintingStyle.fill;

    final path = Path();

    // Start at origin (0, 0)
    path.moveTo(0, 0);
    // Go left (negative X)
    path.lineTo(-60, 0);
    // Curve from (-60, 0) to (0, -60) with an arc (top-left quarter circle)
    path.arcToPoint(
      Offset(0, -60),
      radius: Radius.circular(60),
      clockwise: false,
    );
    // Close path back to origin
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    
    return false; 
  }
  
}