import 'package:sqflite/sqflite.dart';

class DataBase {

  late Database database;
// open the database


  // Insert some records in a transaction
  void insertToDataBaseTable() async {
     await database.transaction((txn) async {
         int id1 = await txn.rawInsert('INSERT INTO TaskTable(title, date, time,state ) VALUES("eating", 12/8, 10:10,new)');
         print('inserted1: $id1');
  // int id2 = await txn.rawInsert(
  // 'INSERT INTO Test(name, value, num) VALUES(?, ?, ?)',
  // ['another name', 12345678, 3.1416]);
  // print('inserted2: $id2');
       });

     // List<Map> list = await database.rawQuery('SELECT * FROM TaskTable');
     //  print(list.toString()) ;
  }
}
