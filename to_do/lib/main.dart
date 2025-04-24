import 'package:flutter/material.dart';
import 'package:to_do/database/android_db.dart';
import 'package:provider/provider.dart';
import 'package:to_do/provider/home_provider.dart';
import 'package:to_do/provider/note_provider.dart';
import 'package:to_do/splesh_screen.dart';
import 'package:to_do/theme/themes.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => HomeProvider()),
      ChangeNotifierProvider(create: (_) => NoteProvider()),
    ],
    child: const MyApp(),
  ));
}

double maxH=0.0,maxW=0.0;


//Window Database
// 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    AndroidDB.instant.initDB();

    maxW = MediaQuery.of(context).size.width;
    maxH = MediaQuery.of(context).size.height;

    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.intant.lightTheme,
      home: SpleshScreen(),
    );
  }
}