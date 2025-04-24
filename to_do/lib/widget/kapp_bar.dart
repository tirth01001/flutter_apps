


import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:to_do/main.dart';
import 'package:to_do/models/actions.dart';

class KappBar<T> extends StatelessWidget implements PreferredSizeWidget {
  
  final CallBackActions<T> ? action;
  final Widget ? title;
  final String ? strTitle;
  final List<Widget> actions;
  final bool showLeading;
  const KappBar({
    super.key,
    this.action,
    this.title,
    this.strTitle,
    this.showLeading=false,
    this.actions=const[]
  });

  
  @override
  Size get preferredSize => Size(maxW, 50);

  @override
  Widget build(BuildContext context) {

    return AppBar(
      leading: showLeading ? IconButton(
        onPressed: action?.onTap ?? (){
          if(Navigator.canPop(context)){
            Navigator.pop(context);
          }
        }, 
        icon: Icon(IconlyLight.arrow_left_2)
      ) : null,
      title: title ?? Text(strTitle??""),
      actions: actions,
    );
  }

}