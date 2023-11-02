import 'package:flutter/material.dart';
import 'package:todoappv1/core/services/cubit/cubit.dart';
import '../../core/constant/colors.dart';
import 'add_task_bottom_sheet.dart';

class NewTaskButton extends StatelessWidget {
  const NewTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        // line over button
        Container(
          width: 2,
          height: 200,
          color: MyColors.primaryOrangeColor,
        ),
        // button
        Container(
          alignment: Alignment.centerLeft,
          height: 100,
          width: 16,
          decoration: const BoxDecoration(
              color: MyColors.primaryOrangeColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                topLeft:  Radius.circular(100),
                bottomLeft: Radius.circular(100),
              )
          ),

          child: IconButton(
              padding: const EdgeInsets.only(right: 2),
              onPressed: (){
                TaskCubit.get(context).emitStateOnEditTask();
                //create data base on the first press
                // show new task dialog
                showBottomSheet(
                  context: context,
                  backgroundColor: MyColors.secondaryBlueColor,
                  builder: (context) {
                    return const CustomBottomSheet() ;
                  },).closed.then((value) {
                  TaskCubit.get(context).getDataFromNewTaskTable(TaskCubit.get(context).database);
                  TaskCubit.get(context).emitStateUsingNavBarIndex();
                });
              },
              icon: const Icon(Icons.add,size: 12,color: MyColors.tertiaryBlueColor,)
          ),
        )
      ],
    );
  }
}
