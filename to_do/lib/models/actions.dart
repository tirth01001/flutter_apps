

import 'package:flutter/material.dart';

class CallBackActions<T> {

  final VoidCallback ? onTap;
  final void Function(String value) ? onChange;
  final void Function(bool ? value) ? onChangeCheckBox;

  CallBackActions({
    this.onTap,
    this.onChange,
    this.onChangeCheckBox
  });

}