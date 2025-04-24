


import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:to_do/main.dart';

class CalenderView extends StatelessWidget {
  const CalenderView({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: maxW,
      height: 500,
      child: MonthView(
        controller: EventController(),
        
      ),
    );
  }
}