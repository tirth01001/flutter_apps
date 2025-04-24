
import 'package:flutter/widgets.dart';

class MangeTaskProvider extends ChangeNotifier {

  List<DateTime> selectedDateTime = [];

  void updateList(List<DateTime> dtime){
    selectedDateTime = dtime;
    notifyListeners();
  }

}