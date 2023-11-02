import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todoappv1/core/services/cubit/cubit.dart';
import 'package:todoappv1/core/services/cubit/states.dart';
import 'package:todoappv1/view/widget/custom_text_form_field.dart';
import '../../core/constant/colors.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskCubit, TaskStates>(
      listener: (context, state) {},
      child: Container(
        width: 300,
        height: 400,
        decoration: const BoxDecoration(color: MyColors.secondaryBlueColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: TaskCubit.get(context).formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Add New Task',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24,
                        color: MyColors.primaryOrangeColor,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextFormField(
                    autofocus: true,
                    controller:
                        TaskCubit.get(context).titleTextEditingController,
                    hintText: 'Task title',
                    validator: (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return 'Can not be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                      hintText: 'Time',
                      keyboardType: TextInputType.none,
                      autofocus: false,
                      controller:
                          TaskCubit.get(context).timeTextEditingController,
                      onTap: () {
                        showTimePicker(
                                context: context, initialTime: TimeOfDay.now())
                            .then((value) {
                          value ??= TimeOfDay.now();
                          TaskCubit.get(context)
                                  .timeTextEditingController
                                  .text =
                              MaterialLocalizations.of(context)
                                  .formatTimeOfDay(value)
                                  .toString();
                        });
                      }),
                  CustomTextFormField(
                      hintText: 'Date',
                      controller:
                          TaskCubit.get(context).dateTextEditingController,
                      keyboardType: TextInputType.none,
                      autofocus: false,
                      onTap: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2023),
                                lastDate: DateTime(2024))
                            .then((value) {
                          value ??= DateTime.now();
                          TaskCubit.get(context)
                                  .dateTextEditingController
                                  .text =
                              DateFormat.yMMMd().format(value).toString();
                        });
                      }),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // save
                      IconButton(
                        onPressed: () {
                          if (TaskCubit.get(context).validChick()) {
                            TaskCubit.get(context).insertDataToDataBase();
                            Navigator.pop(context);
                          }
                        },
                        icon: const Icon(Icons.check,
                            color: MyColors.primaryOrangeColor, size: 30),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      // cansel
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                          TaskCubit.get(context).emitStateUsingNavBarIndex();
                        },
                        icon: const Icon(Icons.close,
                            color: MyColors.tertiaryBlueColor, size: 30),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
