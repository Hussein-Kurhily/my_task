import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:todoappv1/core/constant/colors.dart';
import 'package:todoappv1/view/screen/layout.dart';
import 'core/services/cubit/observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized() ;
  Bloc.observer = MyBlocObserver();
  runApp(const ToDoApp());
}
class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      theme: ThemeData(
        primaryColor: MyColors.primaryOrangeColor,
      ),
      debugShowCheckedModeBanner:   false,
      home: const  Layout(),
    );
  }
}

