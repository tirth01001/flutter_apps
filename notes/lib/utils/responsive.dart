


import 'package:flutter/widgets.dart';

class Responsive {

  static Responsive instant = Responsive();
  final WidgetSizeHandler handler = WidgetSizeHandler();

  double maxW = 0.0;
  double maxH = 0.0;

  BuildContext ? readContent;

  Responsive of(BuildContext context){
    readContent = context;
    return this;
  }

  EdgeInsets getPadding(){
    return EdgeInsets.symmetric(horizontal: 20,vertical: 10);
  }

  void initSize(){
    if(readContent != null){
      maxW = MediaQuery.of(readContent!).size.width;
      maxH = MediaQuery.of(readContent!).size.height;
    }
  }

}


class WidgetSizeHandler {


  //Notes Widget Size Handle here
  double getNotesCardWidth() {
    return 150;
  }
    //Whne Notes Height is 200 then minmun content can be store is 180
  int getMaxLenghtForWrapString() => 180;
  


}