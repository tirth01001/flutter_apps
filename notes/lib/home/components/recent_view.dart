


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/bloc/home/home_bloc.dart';
import 'package:notes/model/notes.dart';
import 'package:notes/utils/responsive.dart';
import 'package:notes/widgets/recent_notes_card.dart';

class RecentView extends StatelessWidget {
  const RecentView({super.key});

  @override
  Widget build(BuildContext context) {
 
    return BlocBuilder<HomeBloc,HomeState>(
      builder: (context,state) {

        if(state.recentNoteId.isEmpty){
          return SizedBox();
        }


        List<NoteModel> filtered = state.notesModels.where((e) => state.recentNoteId.contains(e.id)).toList().reversed.toList();

        return Container(
          width: Responsive.instant.maxW,
          padding: Responsive.instant.getPadding(),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Recent View",style: Theme.of(context).textTheme.labelLarge,),
                Row(
                  children: List.generate(filtered.length, (index){

                    return RecentNotesCard(noteModel: filtered[index],);
                  }),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}