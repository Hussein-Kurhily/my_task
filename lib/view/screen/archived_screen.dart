import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoappv1/core/services/cubit/states.dart';
import '../../core/constant/colors.dart';
import '../../core/services/cubit/cubit.dart';
import '../widget/to_do_tile.dart';

class ArchivedTaskScreen extends StatelessWidget {
  const ArchivedTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<TaskCubit,TaskStates>(
  builder: (context, state) {
    if(TaskCubit.get(context).archivedlist.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: ListView.builder(
          itemCount: TaskCubit.get(context).archivedlist.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              title: TaskCubit.get(context).archivedlist[index]['title'],
              date: TaskCubit.get(context).archivedlist[index]['date'],
              time: TaskCubit.get(context).archivedlist[index]['time'],
              leftSlideIcon: Icons.delete,
              rightSlideIcon: Icons.delete,
              status: false,
              editTask: (editeTask) {
                TaskCubit.get(context).deleteDataFromDataBase(TaskCubit.get(context).newList[index]['id']) ;
              },
              onCheck: (onCheck) {
                // edite task and move it from new screen to done screen
                TaskCubit.get(context).updateArchivedTaskToDoneTask(TaskCubit.get(context).archivedlist[index]['id']) ;
              },
              deleteTask: (BuildContext context) {
                TaskCubit.get(context).deleteDataFromDataBase(TaskCubit.get(context).archivedlist[index]['id']) ;
              },
            );
          },
        ),
      );
    }
    return const Center(
      child: Text(
        "Archived Tasks Is Empty" ,style: TextStyle(
          fontSize: 26,
          color: MyColors.tertiaryBlueColor
      ),
      ),
    ) ;
  },
);
  }
}
