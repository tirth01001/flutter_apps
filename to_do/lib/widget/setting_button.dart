


import 'package:flutter/material.dart';
import 'package:to_do/models/actions.dart';

class SettingButton extends StatelessWidget {
  
  final String btnTitle;
  final String btnDescr;
  final Widget ? prefix;
  final Widget ? suffix;
  final CallBackActions ? action;

  const SettingButton({
    super.key,
    this.btnDescr="",
    this.btnTitle="",
    this.prefix,
    this.suffix,
    this.action
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: action?.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Row(
          children: [
            if(prefix != null) const SizedBox(width: 10,),
            if(prefix != null) prefix!,
            if(prefix != null) const SizedBox(width: 10,),
            IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(btnTitle,style: TextStyle(
                    fontSize: 15,
                  ),),
                  Text(btnDescr,style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey
                  ),),
                ],
              ),
            ),
            Expanded(child: Container()),
            //if(suffix != null) const SizedBox(width: 10,),
            if(suffix != null) suffix!,
            if(suffix != null) const SizedBox(width: 10,),
          ],
        ),
      ),
    );
  }
}