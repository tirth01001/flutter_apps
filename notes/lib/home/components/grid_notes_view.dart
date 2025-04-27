


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes/bloc/home/home_bloc.dart';
import 'package:notes/widgets/notes_view_card.dart';

class GridNotesView extends StatelessWidget {

  final int ? garbage;
  const GridNotesView({super.key,this.garbage});

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<HomeBloc,HomeState>(
      // buildWhen: (previous, current) => previous.updateCount != current.updateCount,
      builder: (context,state) {

        if(state is LoadingState){
          return Center(child: CircularProgressIndicator(),);
        }

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: StaggeredGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            children: List.generate(state.notesModels.length, (index){
              // print(state.notesModels[index].noteType);
              return NotesViewCard(
                model: state.notesModels[index],
              );
            }),
          ),
        );
      }
    );
  }
}