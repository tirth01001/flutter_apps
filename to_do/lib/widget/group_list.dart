



import 'package:flutter/material.dart';

class GroupList extends StatelessWidget {
  
  final Widget ? title;
  final List<Widget> children;
  const GroupList({super.key,this.title,this.children=const[]});

  @override
  Widget build(BuildContext context) {

    return Container(
      child: IntrinsicHeight(
        child: Column(
          children: [
            title??SizedBox(),
            const SizedBox(height: 10,),
            Column(children: children,)
          ],
        ),
      ),
    );
  }
}