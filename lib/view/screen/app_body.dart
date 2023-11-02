import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoappv1/core/services/cubit/cubit.dart';
import 'package:todoappv1/core/services/cubit/states.dart';


class AppBody extends StatelessWidget {
  const AppBody({super.key});

  @override
  Widget build(BuildContext context) {

    print('AppBody') ;
    return BlocBuilder<TaskCubit,TaskStates>(builder: (context, state) {
      return TaskCubit.get(context).screens[TaskCubit.get(context).navBarIndex] ;
    },) ;

  }
}
