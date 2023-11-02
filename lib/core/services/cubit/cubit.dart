import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoappv1/core/services/cubit/states.dart';
import '../../../view/screen/archived_screen.dart';
import '../../../view/screen/done_screen.dart';
import '../../../view/screen/new_task_screen.dart';

class TaskCubit extends Cubit<TaskStates> {
  TaskCubit() : super(InItState());

  List<Map<String, dynamic>> newList = [] ;
  List<Map<String, dynamic>> donelist = [];
  List<Map<String, dynamic>> archivedlist = [];


  static TaskCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = const [
    DoneScreen(),
    NewTaskScreen(),
    ArchivedTaskScreen(),
  ];

  int navBarIndex = 1;


                // change the nav par index when tapped by calling
  void changeIndex(int index) {
    navBarIndex = index;
    emitStateUsingNavBarIndex();
  }
           //                  emit functions                \\
  void emitStateUsingNavBarIndex() {
    // getDataFromDataBase();
    if (navBarIndex == 0) {
      getDataFromDoneTaskTable(database).then((value) {
        emit(DoneState());
      }) ;

    }
    if (navBarIndex == 1) {
        getDataFromNewTaskTable(database).then((value) {
          emit(NewTaskState());
        }) ;

    }
    if (navBarIndex == 2) {
      getDataFromArchivedTaskTable(database).then((value) {
        emit(ArchivedTaskState());
      }) ;

    }
  }
  void emitStateOnAddTask()  {
    emit(AddTaskState());
  }
  void emitStateOnEditTask () {
    emit(EditTaskState()) ;
  }



  Database? database ;

             //**             create database and open                **\\
  Future<void> createDataBaseAndOpen()  async {
    openDatabase('task_db.db', version: 1,
        onCreate: (db,version) async {
      // When creating the db, create the table
          await db.execute('CREATE TABLE TaskTable(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,state TEXT)');


          },
        onOpen: (db) async {
             getDataFromNewTaskTable(db).then((value) {

              newList = value ;
            }) ;
         },
    ).then((value) {
      database = value ;
      emit(CreateDataBaseState());
    }) ;

  }

                   //**         get functions        **\\

  // get new tasks
  Future<List<Map<String, dynamic>>>  getDataFromNewTaskTable(database) async {
    newList = [] ;
    newList = await database.rawQuery('SELECT * FROM TaskTable WHERE state = ?',['NEW']) ;
    emit(GetDataFromDataBaseState()) ;
    return   newList ;
  }

  // get done tasks
  Future<List<Map<String, dynamic>>>  getDataFromDoneTaskTable(database) async {
    donelist = [] ;
    donelist = await database.rawQuery('SELECT * FROM TaskTable WHERE state = ?',['DONE']) ;
    emit(GetDataFromDataBaseState()) ;
    return   donelist ;
  }

// get archived tasks
  Future<List<Map<String, dynamic>>>  getDataFromArchivedTaskTable(database) async {
    archivedlist = [] ;
    archivedlist = await database.rawQuery('SELECT * FROM TaskTable WHERE state = ?',['ARCHIVED']) ;
    emit(GetDataFromDataBaseState()) ;

    return   archivedlist ;
  }



  //                  Insert some records in a transaction
  void insertDataToDataBase() async {
    String title = titleTextEditingController.text;
    String date = dateTextEditingController.text;
    String time = timeTextEditingController.text;
    Database database = await openDatabase('task_db.db', version: 1,);
    await database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO TaskTable(title, date, time, state) VALUES(?, ?, ?, ?)',
          [title, date, time, 'NEW']) ;
    }).catchError((e){

    });
    await getDataFromNewTaskTable(database) ;
    reSetControllers() ;
    emit(InsertDataToDataBaseState());
  }

  //                      Delete a record
  Future<void> deleteDataFromDataBase(int index) async {
    Database database = await openDatabase('task_db.db', version: 1);
     database.rawDelete('DELETE FROM TaskTable  WHERE id = ?', [index]).then((value) {
       emitStateUsingNavBarIndex();
     });

  }



                   // edite task (title || time || date)
  Future<void> getTaskInfoToEdit({required int id}) async {
    var task = await database!.rawQuery('SELECT * FROM TaskTable WHERE id = ?',[id]) ;
    titleTextEditingController.text = task[0]['title'].toString();
    timeTextEditingController.text = task[0]['time'].toString() ;
    dateTextEditingController.text = task[0]['date'].toString();

  }
// required int id, required String title, required String time, required String date}
  Future<void> updateTask({required int id}) async {
    String title = titleTextEditingController.text  ;
    String time=   timeTextEditingController.text ;
    String date=    dateTextEditingController.text ;
    await database!.rawUpdate(
        'UPDATE TaskTable SET title = ?, date = ?, time = ?  WHERE id = ? ',
        [title,date,time,id]  //, time, date,
    ).then((value) {
      emitStateUsingNavBarIndex();
      reSetControllers() ;
    }) ;
  }


  // move the task between screens
  Future<void> updateNewTaskToDoneTask(int id) async {
    await database!.rawUpdate('UPDATE TaskTable SET state = ? WHERE state = ? and id = ? ',
        ['DONE','NEW',id]) ;
    emitStateUsingNavBarIndex();
  }
  Future<void> updateNewTaskToArchivedTask(int id) async {
    await database!.rawUpdate('UPDATE TaskTable SET state = ? WHERE state = ? and id = ? ',
        ['ARCHIVED','NEW',id]) ;
    emitStateUsingNavBarIndex();
  }
  Future<void> updateArchivedTaskToDoneTask(int id) async {
    await database!.rawUpdate('UPDATE TaskTable SET state = ? WHERE state = ? and id = ? ',
        ['DONE','ARCHIVED',id]) ;
    emitStateUsingNavBarIndex();
  }


  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController timeTextEditingController = TextEditingController();
  TextEditingController dateTextEditingController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  void reSetControllers() {
    titleTextEditingController.clear();
    timeTextEditingController.clear();
    dateTextEditingController.clear();
  }

  bool validChick() {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
}
