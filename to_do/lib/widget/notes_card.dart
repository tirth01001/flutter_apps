


import 'package:flutter/material.dart';
import 'package:to_do/models/actions.dart';

class NotesCard extends StatelessWidget {
  
  final String title;
  final String content;
  final CallBackActions ? actions;
  const NotesCard({
    super.key,
    this.title="",
    this.content="",
    this.actions
  });


  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: actions?.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8)
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,style: TextStyle(
                      fontSize: 17,
                    ),),
                    Divider(),
                    Text(content.getStringClip(200)),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(colors: [
                    // Colors.pink.withValues(alpha: 0.0),
                    Colors.grey.withValues(alpha: 0.0),
                    Colors.grey.withValues(alpha: 0.0),
                    Colors.grey.withValues(alpha: 0.9),
                  ],begin: Alignment.topCenter,end: Alignment.bottomCenter)
                ),
              )
            )
          ],
        ),
      ),
    );
  }
  
}

extension _tool on String {

  String getStringClip(int maxRange){
    if(length < maxRange){
      return this;
    }
    String str = substring(0,maxRange);
    return "$str...";
  }

}