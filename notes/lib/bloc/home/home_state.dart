
part of 'home_bloc.dart';

class HomeState {

  //Conf
  int bottomIndex;
  int tagID;
  int updateCount;
  List<NoteModel> notesModels;
  List<Category> notesTypes;
  List<int> recentNoteId;

  HomeState({
    this.tagID=0,
    this.bottomIndex=0,
    this.updateCount=0,
    this.notesModels=const[],
    this.notesTypes=const[],
    this.recentNoteId=const[]
  });
  
  HomeState update(HomeState state) => HomeState(
    bottomIndex: state.bottomIndex,
    tagID: state.tagID,
    notesModels: state.notesModels,
    updateCount: state.updateCount,
    notesTypes: state.notesTypes,
    recentNoteId: state.recentNoteId
  );

  HomeState updateByValue({
    int ? bIndex,int ? aIndex,
    List<NoteModel>  ?listOfModel,int ? count,
    List<Category> ? categorys,
    List<int> ? recentNotes,
  }) => HomeState(
    bottomIndex: bIndex ?? bottomIndex,
    tagID: aIndex ?? tagID,
    notesModels: listOfModel ?? notesModels,
    updateCount: count ?? updateCount,
    notesTypes: categorys ?? notesTypes,
    recentNoteId: recentNotes ?? recentNoteId
  );

}

class LoadingState extends HomeState {
  LoadingState(HomeState state):super(
    tagID: state.tagID,
    bottomIndex: state.bottomIndex,
    notesModels: state.notesModels,
    updateCount: state.updateCount,
    notesTypes: state.notesTypes,
    recentNoteId: state.recentNoteId
  );
}

class DataLoadedState extends HomeState {

  DataLoadedState(HomeState state):super(
    tagID: state.tagID,
    bottomIndex: state.bottomIndex,
    notesModels: state.notesModels,
    updateCount: state.updateCount,
    notesTypes: state.notesTypes,
    recentNoteId: state.recentNoteId
  );
}
