import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoappv1/core/services/cubit/states.dart';
import '../../core/constant/colors.dart';
import '../../core/services/cubit/cubit.dart';


class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit,TaskStates> (
      builder: (context, state) {
        return CurvedNavigationBar(
          height: 50,
          index: 1,
          animationDuration: const Duration(milliseconds: 330),
          buttonBackgroundColor: MyColors.primaryOrangeColor,
          backgroundColor: MyColors.secondaryBlueColor,
          color: MyColors.primaryBlueColor,
          items: const <Widget>[
            Icon(Icons.check, size: 26, color: MyColors.tertiaryBlueColor,),
            Icon(Icons.table_rows_rounded, size: 26,
              color: MyColors.tertiaryBlueColor,),
            Icon(Icons.archive_outlined, size: 26,
              color: MyColors.tertiaryBlueColor,),
          ],
          onTap: (index) {
            TaskCubit.get(context).changeIndex(index);
            print(index) ;
            print(TaskCubit.get(context).getDataFromNewTaskTable(TaskCubit.get(context).database) ) ;
          },
        ) ;
      },
    );
  }
}
