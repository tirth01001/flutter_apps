



import 'package:flutter/material.dart';

class TagView extends StatelessWidget {

  final String text;
  const TagView({super.key,required this.text});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text),
    );
  }
}