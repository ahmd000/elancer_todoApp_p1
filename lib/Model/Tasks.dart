class Tasks {
  late int id;
  late String taskName;
  late String email;
  late String taskDescription;
  late String taskState;

  late String finalDateTask;

  Tasks();

  ///Used to read table row data and convert it to a model.

  Tasks.fromMap(Map<String, dynamic> rowMap) {
    id = rowMap['id'];
    taskName = rowMap['task_name'];
    email = rowMap['email'];
    taskDescription = rowMap['task_description'];
    taskState = rowMap['task_state'];
    finalDateTask = rowMap['final_date'];
  }

  ///Used to save data in a database table.

  Map<String, dynamic> toMap() {
    Map<String, dynamic> rowMap = <String, dynamic>{};
    rowMap['task_name'] = taskName;
    rowMap['task_description'] = taskDescription;
    rowMap['email'] = email;
    rowMap['task_state'] = taskState;
    rowMap['final_date'] = finalDateTask;
    return rowMap;
  }
}
