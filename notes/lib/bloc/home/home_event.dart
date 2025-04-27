

part of 'home_bloc.dart';


abstract class HomeEvent {}

class BottomNavigationEvent extends HomeEvent {

  int index;
  BottomNavigationEvent(this.index);

}


class CategoryTageEvent extends HomeEvent {

  final int tageEvent;
  final String categoryText;
  CategoryTageEvent(this.tageEvent,this.categoryText);

}


class ReloadEvent extends HomeEvent {

  final bool tagAlso;
  final bool recentViewAlso;
  ReloadEvent({this.tagAlso=false,this.recentViewAlso=false});

}

class ReloadTagEvent extends HomeEvent {}

class ReloadRecentViewEvent extends HomeEvent {

}