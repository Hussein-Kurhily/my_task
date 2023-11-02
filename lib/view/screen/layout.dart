import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoappv1/core/constant/colors.dart';
import 'package:todoappv1/core/services/cubit/cubit.dart';
import 'package:todoappv1/core/services/cubit/states.dart';
import '../widget/custom_bottom_nav_bar.dart';
import '../widget/new_task_button.dart';
import 'app_body.dart';

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context)  {
    return SafeArea(
      child: BlocProvider<TaskCubit>(
        create: (context) => TaskCubit()..createDataBaseAndOpen(),
        child: BlocBuilder<TaskCubit, TaskStates>(
            builder: (context, state)  {
              return const Scaffold(
                backgroundColor: MyColors.secondaryBlueColor,
                bottomNavigationBar: CustomBottomNavBar(),
                body: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    AppBody(),
                    NewTaskButton(),
                  ],
                ),
              ) ;
            },

        ),
      ),
    );
  }
}
