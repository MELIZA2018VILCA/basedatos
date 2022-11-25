import 'dart:io';

import 'package:basedatos/models/task_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBAdmin {
  Database? myDatabase;

  static final DBAdmin db = DBAdmin._();
  DBAdmin._();

  Future<Database?> chekDatabase() async {
    if (myDatabase != null) {
      return myDatabase;
    }

    myDatabase = await initDatabase();
    return myDatabase;
  }

  Future<Database> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "agenda.db");
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database dbx, int version) async {
        //crear la tabla correspondiente
        await dbx.execute(
            "CREATE TABLE task(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, descripcion TEXT, status TEXT)");
      },
    );
  }

  insertRawTask() async {
    Database? db = await chekDatabase();
    int rest = await db!.rawInsert(
        "INSERT INTO TASK(TITLE,descripcion, status) values ('ir de compras','tenemos que ir a totus','falso')");
    print(rest);
  }

  insertTask() async {
    Database? db = await chekDatabase();
    int rest = await db!.insert(
      "TASK",
      {
        "title": "comprar el nuevo disco",
        "descripcion": "nuevo disco",
        "status": "false",
      },
    );
    print(rest);
  }

  getRawTasks() async {
    Database? db = await chekDatabase();
    List tasks = await db!.rawQuery("SELECT * FROM Task");
    print(tasks[0]);
  }

   Future<List<taskModel>> getTasks() async {
    Database? db = await chekDatabase();
    List<Map<String, dynamic>> tasks = await db!.query("Task");
    List<taskModel> taskModelList = tasks.map((e) => taskModel.deMapAModel(e)).toList();

    /* tasks.forEach((element) {
      taskModel task = taskModel.deMapAModel(element)
     taskModelList.add(task);
    }); */
    print(taskModelList);

    return taskModelList;
  
  }

  updateRawTasks() async {
    Database? db = await chekDatabase();
    db!.rawUpdate(
        "UPDATE TASK SET title = 'ir de compras',descripcion = 'comprar comida', status = 'true' where id = 2");
  }

  updateTask() async {
    Database? db = await chekDatabase();
    db!.update(
      "TASK",
      {
        "title": "ir al cine",
        "descripcion": "viernes por la tarde",
        "status": "false",
      },
      where: "id=2"
    );
  }
  deleteRawTask()async{
      Database? db = await chekDatabase();
      int rest = await db!.rawDelete("DELETE FROM TASK WHERE id = 2");
      print(rest);
  }
  deteleTask()async{
    Database? db = await chekDatabase();
    int rest = await db!.delete("TASK",where: "id=2");
    print(rest);

  }

}
