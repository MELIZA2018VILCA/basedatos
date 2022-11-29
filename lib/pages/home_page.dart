import 'package:basedatos/db/db_admin.dart';
import 'package:basedatos/models/task_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  Future<String> getFullName() async{
    return "juan manuel";
  }

  @override
  Widget build(BuildContext context) {
    DBAdmin.db.getRawTasks(); 
    return Scaffold(
      appBar: AppBar(
        title: Text("home Page"),
      ),
      body: FutureBuilder(
        future: DBAdmin.db.getTasks(),
        builder: (BuildContext context, AsyncSnapshot  snap) {
          if (snap.hasData) {
            List<taskModel> myTasks = snap.data;
            return ListView.builder(
              itemCount: myTasks.length,
              itemBuilder: (BuildContext context, int index){
                return ListTile(
                  title: Text(myTasks[index].title),
                  subtitle: Text(myTasks[index].descripcion),
                  trailing: Text(myTasks[index].id.toString()),
                );
              },
            );
          }
          return const Center(
              child: CircularProgressIndicator(),
            );
        },
      ),

     
     
    );
  }
}
