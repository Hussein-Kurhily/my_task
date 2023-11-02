import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoappv1/core/services/cubit/states.dart';
import '../../core/constant/colors.dart';
import '../../core/services/cubit/cubit.dart';
import '../widget/to_do_tile.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<TaskCubit,TaskStates>(
  builder: (context, state) {
    if(TaskCubit.get(context).donelist.isNotEmpty){
      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: ListView.builder(
          itemCount:TaskCubit.get(context).donelist.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              title: TaskCubit.get(context).donelist[index]['title'],
              date: TaskCubit.get(context).donelist[index]['date'],
              time: TaskCubit.get(context).donelist[index]['time'],
              leftSlideIcon: Icons.delete,
              rightSlideIcon: Icons.delete,
              status: true,
              onCheck: (onCheck) {},
              deleteTask: (BuildContext context) {
                TaskCubit.get(context).deleteDataFromDataBase(TaskCubit.get(context).donelist[index]['id']) ;

              },
              editTask: (editeTask) {
                TaskCubit.get(context).deleteDataFromDataBase(TaskCubit.get(context).donelist[index]['id']) ;
              },
            );
          },
        ),
      );
    }
    return const Center(
      child: Text(
        "Lets Complete Task" ,style: TextStyle(
          fontSize: 26,
          color: MyColors.tertiaryBlueColor
      ),
      ),
    ) ;
  },
);
  }
}
