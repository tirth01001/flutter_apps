import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:notes/bloc/bottom_nav/bottom_navigation_cubit.dart';
import 'package:notes/bloc/home/home_bloc.dart';
import 'package:notes/home/home.dart';
import 'package:notes/utils/responsive.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => HomeBloc()..add(ReloadEvent(tagAlso: true,recentViewAlso: true))),
      BlocProvider(create: (_) => BottomNavigationCubit()),
    ], 
    child: const MyApp()
  ));
}


class MyApp extends StatelessWidget {

  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    Responsive.instant.of(context).initSize();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        FlutterQuillLocalizations.delegate
      ],
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 20,),
          bodyMedium: TextStyle(fontSize: 16,),
          bodySmall: TextStyle(fontSize: 12),
          headlineLarge: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
          headlineMedium: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),
          headlineSmall: TextStyle(fontSize: 12,color: Colors.grey),
          labelLarge: TextStyle(fontSize: 18,),
          labelMedium: TextStyle(fontSize: 16)
        )
      ),
      home: Home(),
    );
  }
}