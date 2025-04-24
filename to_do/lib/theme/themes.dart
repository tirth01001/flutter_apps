


import 'package:flutter/material.dart';

class Themes {

  static Themes intant = Themes();


  final ThemeData lightTheme = ThemeData(
    // adaptations: Iterable.generate(1),
    appBarTheme: AppBarTheme(
      // backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 10,
    ),
    // scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)
  );


  final ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(
        color: Colors.white,
      )
    ),
    scaffoldBackgroundColor: Colors.black
  );
  

}