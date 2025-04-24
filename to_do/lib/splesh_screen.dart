


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:to_do/home/home.dart';
import 'package:to_do/provider/home_provider.dart';

class SpleshScreen extends StatefulWidget {
  const SpleshScreen({super.key});

  @override
  State<SpleshScreen> createState() => _SpleshScreenState();
}

class _SpleshScreenState extends State<SpleshScreen> {
  
  @override
  void initState() {
    super.initState();
    context.read<HomeProvider>().preLoadDate();
    Timer(const Duration(seconds: 2), (){
      context.read<HomeProvider>().update();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Icon(IconlyLight.activity),
      ),
    );
  }
}