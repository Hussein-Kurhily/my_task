import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoappv1/core/services/cubit/cubit.dart';
import 'package:todoappv1/core/services/cubit/states.dart';
import '../../core/constant/colors.dart';
import '../widget/edit_task_bottom_sheet.dart';
import '../widget/to_do_tile.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: BlocBuilder<TaskCubit, TaskStates>(
        builder: (context, state) {
          if(TaskCubit.get(context).newList.isNotEmpty){
            return ListView.builder(
              itemCount: TaskCubit.get(context).newList.length,
              itemBuilder: (context, index) {
                return ToDoTile(
                  title: TaskCubit.get(context).newList[index]['title'],
                  date: TaskCubit.get(context).newList[index]['date'],
                  time: TaskCubit.get(context).newList[index]['time'],
                  leftSlideIcon: Icons.edit,
                  rightSlideIcon: Icons.delete,
                  leftSlideBackgroundColor: Colors.green[300],
                  status: false,
                  onLongPress: () {
                    showDialog(
                        context: context,
                        builder: (myContext) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Container(
                              width: 70,
                              height: 152,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: MyColors.tertiaryBlueColor,
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Do you want to archive this task ?",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: MyColors.secondaryBlueColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      // save
                                      IconButton(
                                        onPressed: () {
                                          TaskCubit.get(context)
                                              .updateNewTaskToArchivedTask(
                                              TaskCubit.get(context)
                                                  .newList[index]['id']);
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(Icons.check,
                                            color:
                                            MyColors.primaryOrangeColor,
                                            size: 30),
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      // cansel
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(Icons.close,
                                            color: MyColors.primaryBlueColor,
                                            size: 30),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  editTask: (editeTask) {
                    TaskCubit.get(context).emitStateOnAddTask();
                    // show new task dialog
                    showBottomSheet(
                      context: context,
                      backgroundColor: MyColors.secondaryBlueColor,
                      builder: (myContext) {
                        TaskCubit.get(context).getTaskInfoToEdit(
                          id: TaskCubit.get(context).newList[index]['id'] ,
                        ) ;
                        return  EditTaskCustomBottomSheet(
                          id: TaskCubit.get(context).newList[index]['id'],
                        ) ;
                      },).closed.then((value) {
                      TaskCubit.get(context).getDataFromNewTaskTable(TaskCubit.get(context).database);
                      TaskCubit.get(context).emitStateUsingNavBarIndex();
                    });
                  },
                  onCheck: (onCheck) {
                    // edite task and move it from new screen to done screen
                    TaskCubit.get(context).updateNewTaskToDoneTask(
                        TaskCubit.get(context).newList[index]['id']);
                  },
                  deleteTask: (BuildContext context) {
                    TaskCubit.get(context).deleteDataFromDataBase(
                        TaskCubit.get(context).newList[index]['id']);
                  },
                );
              },
            );
          }
          return const Center(
            child: Text(
              "Add New Task" ,style: TextStyle(
              fontSize: 26,
              color: MyColors.tertiaryBlueColor
            ),
            ),
          ) ;
        },
      ),
    );
  }
}
