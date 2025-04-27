

import 'package:flutter/material.dart';

class NoteToolButton extends StatelessWidget {
  
  final Widget ? icon;
  final IconData ? iconData;
  final String ? textString;
  final Widget ? text;
  final VoidCallback ? onTap;

  const NoteToolButton({
    super.key,
    this.icon,
    this.iconData,
    this.text,
    this.textString,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.orange.shade100,
          borderRadius: BorderRadius.circular(8)
        ),
        child: icon,
      ),
    );
    // return Container(
    //   margin: const EdgeInsets.symmetric(horizontal: 7),
    //   padding: const EdgeInsets.symmetric(vertical: 4),
    //   decoration: BoxDecoration(
    //     color: Colors.orange.shade400,
    //     borderRadius: BorderRadius.circular(8)
    //   ),
    //   child: Row(
    //     children: [
    //       if(iconData != null || icon != null) const SizedBox(width: 10,),
    //       if(icon != null) icon!
    //       else if(iconData != null) Icon(iconData),
    //       if(iconData != null || icon != null) const SizedBox(width: 10,),
    //       // if(text != null || textString != null) const SizedBox(width: 10,),
    //       if(text != null) text!
    //       else if(textString != null) Text(textString??"",style: Theme.of(context).textTheme.bodySmall,),
    //       if(text != null || textString != null) const SizedBox(width: 10,),
    //     ],
    //   ),
    // );
  }
}