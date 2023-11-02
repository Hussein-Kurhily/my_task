import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoappv1/core/constant/colors.dart';

class ToDoTile extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final bool status;
  final Function(bool?)? onCheck;
  final void Function(BuildContext)? deleteTask;
  final void Function(BuildContext)? editTask;
  final void Function()? onLongPress ;
  final IconData leftSlideIcon ;
  final IconData rightSlideIcon ;
  final Color? leftSlideBackgroundColor  ;


  const ToDoTile(
      {super.key,
      required this.title,
      required this.status,
      required this.onCheck,
      required this.deleteTask,
      required this.editTask,
      required this.date,
        this.onLongPress ,
        this.leftSlideBackgroundColor,
      required this.time, required this.leftSlideIcon, required this.rightSlideIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 10),
      child: Slidable(
        //right to left
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(12),
            onPressed:  deleteTask,
            icon: rightSlideIcon ,
            backgroundColor: Colors.red[300]!,
          )
        ]),

        //left to right
        startActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(12),
            onPressed: editTask,
            icon: leftSlideIcon ,
            backgroundColor: leftSlideBackgroundColor ?? Colors.red[300]!,
          )
        ]),

        // task container
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                  color: MyColors.primaryBlueColor,
                  borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Checkbox(
                    shape: const CircleBorder(),
                    value: status,
                    onChanged: onCheck,
                    checkColor: MyColors.secondaryBlueColor,
                    activeColor: MyColors.primaryOrangeColor,
                  ),
                  GestureDetector(
                    onLongPress: onLongPress,
                    child: SizedBox(
                      width: 150,
                      child: Text(
                        title,
                        maxLines: 3,
                        style: TextStyle(
                          overflow:  TextOverflow.ellipsis ,
                            decoration: status
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      ),
                    ),
                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Time : $time', style:const TextStyle(fontSize: 12),),
                  const SizedBox(
                    height: 2,
                  ),
                  Text('Date : $date', style:const TextStyle(fontSize: 12))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
