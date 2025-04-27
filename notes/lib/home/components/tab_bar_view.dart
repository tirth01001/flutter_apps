


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:notes/bloc/home/home_bloc.dart';
import 'package:notes/database/wind_db.dart';
import 'package:notes/model/category.dart';

class KTabBarView extends StatefulWidget {

  const KTabBarView({super.key});

  @override
  State<KTabBarView> createState() => _KTabBarViewState();
}

class _KTabBarViewState extends State<KTabBarView> {

  Widget tabButton({Widget ? icon,Widget ? title,String ? txt ,VoidCallback ? onTap,bool active=false})  => Padding(
    padding: const EdgeInsets.only(left: 20,top: 20,),
    child: RawChip(
      padding: const EdgeInsets.only(left: 0,bottom: 6,top: 6),
      side: active ? BorderSide(
        color: Colors.orange
      ) : BorderSide(
        color: Colors.grey
      ),
      backgroundColor: active ? Colors.orange.withValues(alpha: .1)  : Colors.grey.withValues(alpha: .1),
      onPressed: onTap,
      label: Row(
        children: [
          icon ?? Icon(Icons.read_more),
          if(title != null) const SizedBox(width: 10,),
          title ?? Text(txt  ??"Reading",style: Theme.of(context).textTheme.bodyMedium,)
        ],
      ),
    ),
  );
  
  @override
  Widget build(BuildContext context) {

    
    return BlocBuilder<HomeBloc,HomeState>(
      builder: (context,state) {
        
        // print(state.notesTypes);
    
    
        return Row(
          children: [
    
            ...state.notesTypes.map((ele) => tabButton(
              icon: SizedBox(),
              txt: ele.type,
              active: ele.id == state.tagID,
              onTap: () {
                context.read<HomeBloc>().add(CategoryTageEvent(ele.id,ele.type));
              },
            )),
    
            tabButton(
              icon: Icon(IconlyLight.plus),
              txt: "ADD",
              onTap: () {
                final TextEditingController controller = TextEditingController();
                showDialog(
                  context: context, 
                  builder: (context) {
                    
                    return AlertDialog(
                      title: Text("Create Tag"),
                      content: Container(
                        child: Column(
                          children: [
                            TextField(
                              controller: controller,
                            ),
                            ElevatedButton(onPressed: () {
                              
                              Category category = Category(
                                type: controller.text,
                                noteId: 0,
                              );
                              WindDb.instance.insertCategory(category);
                              context.read<HomeBloc>().add(ReloadTagEvent());
    
                            }, child: Text("SAve")),
                            ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text("Cancel")),
                          ],
                        ),
                      ),
                    );
                  },
                );
    
              },
            )
        
       
          ],
        );
      }
    );
  }
}