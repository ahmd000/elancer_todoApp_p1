import 'package:elancer_todo_p1/Constanse/Constanse.dart';
import 'package:elancer_todo_p1/Model/Tasks.dart';
import 'package:elancer_todo_p1/database/controllers/tasks_db_controller.dart';
import 'package:flutter/material.dart';

class TasksProvider extends ChangeNotifier {
  List<Tasks> tasks = <Tasks>[];
  final TasksDbController _tasksDbController = TasksDbController();

  //CRUD
  Future<void> read() async {
        tasks = await _tasksDbController.read();
    notifyListeners();
  }

  Future<bool> create(Tasks task) async {
    int newRowId = await _tasksDbController.create(task);
    if (newRowId != 0) {
      task.id = newRowId;
      tasks.add(task);
      notifyListeners();
    }
    return newRowId != 0;
  }

  Future<bool> delete(int id) async {
    bool deleted = await _tasksDbController.delete(id);
     // tasks.removeWhere((element) => element.id == id);
    if (deleted) {
      int index = tasks.indexWhere((element) => element.id == id);
      if (index != -1) {
        tasks.remove(index);
        notifyListeners();
      }
    }

    return deleted;
  }

  Future<bool> update(Tasks task) async {
    bool updated = await _tasksDbController.update(task);

    if (updated) {
      // int index = tasks.indexOf(task);

      int index = tasks.indexWhere((element) => element.id == task.id);
      tasks[index] = task;
      if (index != -1) {
        tasks[index] = task;
        notifyListeners();
      }
    }

    return updated;
  }
}
