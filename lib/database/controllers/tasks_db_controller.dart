import 'package:elancer_todo_p1/Model/Tasks.dart';
import 'package:elancer_todo_p1/database/db_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sqflite/sqflite.dart';
import '../db_operations.dart';

class TasksDbController implements DbOperations<Tasks> {
  final Database _database = DbController().database;
  @override
  Future<int> create(Tasks object) async {
    return await _database.insert("Tasks", object.toMap());
  }

  @override
  Future<bool> delete(int id) async {
    //DELETE FROM contacts;
    //DELETE FROM contacts WHERE id = 1;
    int numberOfDeletedRows = await _database.delete(
      'Tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
    return numberOfDeletedRows > 0;
  }

  @override
  Future<List<Tasks>> read() async {
    List<Map<String, dynamic>> rowsMap = await _database.query("Tasks",where: 'email = ?',whereArgs: [FirebaseAuth.instance.currentUser!.email]);
    return rowsMap.map((rowMap) => Tasks.fromMap(rowMap)).toList();
  }

  @override
  Future<Tasks?> show(int id) async {
    List<Map<String, dynamic>> rows =
        await _database.query("Tasks", where: "id", whereArgs: [id]);
    rows.isNotEmpty ? Tasks.fromMap(rows.first) : null;
    // if(rows.isNotEmpty){
    //   Tasks tasks = Tasks.fromMap(rows.first );
    // }
  }

  @override
  Future<bool> update(Tasks object) async {
    int numberOfUpdatesRows = await _database.update(
      "Tasks",
      object.toMap(),
      whereArgs: [object.id],
      where: "id =?",
    );
    return numberOfUpdatesRows > 0;
  }
}
