


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/database/wind_db.dart';
import 'package:notes/model/category.dart';
import 'package:notes/model/notes.dart';

part 'home_state.dart';
part 'home_event.dart';


class HomeBloc extends Bloc<HomeEvent,HomeState> {
  
  HomeBloc():super(HomeState()){

    on<BottomNavigationEvent>(_bottomNavigation);
    on<CategoryTageEvent>(_selectCategory);
    on<ReloadEvent>(_reload);
    on<ReloadTagEvent>(_reloadTag);
    on<ReloadRecentViewEvent>(_reloadRecentView);

  }



  void _bottomNavigation(BottomNavigationEvent event,Emitter<HomeState> emit){
    emit(state.updateByValue(
      bIndex: event.index
    ));
  }


  void _selectCategory(CategoryTageEvent event,Emitter<HomeState> emit) async {
    emit(state.updateByValue(
      aIndex: event.tageEvent
    ));
    emit(LoadingState(state));
    List<NoteModel> filteredData;
    if(event.categoryText.toLowerCase() == "all"){
      filteredData = await WindDb.instance.notes;
    }else{
      filteredData= await WindDb.instance.getNoteByCategoyr(event.categoryText);
    }
    emit(DataLoadedState(state.updateByValue(
      listOfModel: filteredData
    )));
  }




  void _reload(ReloadEvent event,Emitter<HomeState> emit) async {
    emit(LoadingState(state));
    List<Category> dbCat = List.from(state.notesTypes);
    List<int> recId = List.from(state.recentNoteId);
    if(event.tagAlso){
      dbCat = await WindDb.instance.noteTypes;
    }
    if(event.recentViewAlso){
      recId = await WindDb.instance.recentIds;
    }
    List<NoteModel> fromDB = await WindDb.instance.notes;
    // print(fromDB);
    emit(DataLoadedState(state.updateByValue(
      listOfModel: fromDB,
      categorys: dbCat,
      aIndex: dbCat.first.id,
      recentNotes: recId
    )));
  }

  void _reloadTag(ReloadTagEvent event,Emitter<HomeState> emit) async {
    emit(LoadingState(state));
    List<Category> fromDB = await WindDb.instance.noteTypes;
    // print(fromDB);
    emit(DataLoadedState(state.updateByValue(
      categorys: fromDB
    )));
  }


  void _reloadRecentView(ReloadRecentViewEvent event,Emitter<HomeState> emit) async {
    emit(LoadingState(state));
    List<int> recentNoteId = await WindDb.instance.recentIds;
    emit(DataLoadedState(state.updateByValue(
      recentNotes: recentNoteId
    )));
  }


}