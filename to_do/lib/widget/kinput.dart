


import 'package:flutter/material.dart';
import 'package:to_do/models/actions.dart';

class KInput extends StatelessWidget {
  
  final TextEditingController ? controller;
  final CallBackActions ? actions;
  final Widget ? leading;
  final Widget ? tralling;
  final String ? hint;
  final int ? maxLine;
  final bool expanded;
  const KInput({
    super.key,
    this.controller,
    this.actions,
    this.leading,
    this.tralling,
    this.hint,
    this.maxLine,
    this.expanded=false
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0,vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          if(leading != null) const SizedBox(width: 10,),
          if(leading != null) leading!,
          if(leading != null) const SizedBox(width: 10,),
          Expanded(
            child: TextField(
              maxLines: maxLine,
              expands: expanded,
              onChanged: actions?.onChange,
              onTap: actions?.onTap,
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint
              ),
            ),
          ),
          if(tralling != null) const SizedBox(width: 10,),
          if(tralling != null) tralling!,
          if(tralling != null) const SizedBox(width: 10,),
        ],
      ),
    );
  }
}