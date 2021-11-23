import 'package:elancer_todo_p1/Constanse/Constanse.dart';
import 'package:elancer_todo_p1/Model/Tasks.dart';
import 'package:elancer_todo_p1/Provider/TasksProvider.dart';
import 'package:elancer_todo_p1/Widgets/app_text_field.dart';
import 'package:elancer_todo_p1/helpers/helpers.dart';
import 'package:elancer_todo_p1/translations/locale_key.g.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen(
      {Key? key, required this.tasks, this.title = "Update Task"})
      : super(key: key);
  final Tasks tasks;
  final String title;

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> with Helpers {
  late TextEditingController _taskTextController;
  late TextEditingController _detailsTaskTextController;
  String _taskStatue = "a";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _taskTextController = TextEditingController(text: widget.tasks.taskName);
    _detailsTaskTextController =
        TextEditingController(text: widget.tasks.taskDescription);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _taskTextController.dispose();
    _detailsTaskTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.updateTask.tr()),
      ),
      body: ListView(
        // physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          Text(
            LocaleKeys.updateTask.tr(),
            // 'Enter new Task ',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 15),
          AppTextField(
            textEditingController: _taskTextController,
            hint: LocaleKeys.task.tr(),
            prefixIcon: Icons.person,
          ),
          SizedBox(height: 10),
          const SizedBox(height: 10),
          AppTextField(
            textEditingController: _detailsTaskTextController,
            hint: LocaleKeys.taskDetail.tr(),
            prefixIcon: Icons.phone_android,
          ),
          const SizedBox(height: 10),




          RadioListTile<String>(
              title: Text(LocaleKeys.moveToActive.tr()),
              value: isActive,
              groupValue: _taskStatue,
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    _taskStatue = value;
                    print(value);
                  });
                }
              }),
          RadioListTile<String>(
              title: Text(LocaleKeys.moveToProgress.tr()),
              value: isProgress,
              groupValue: _taskStatue,
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    _taskStatue = value;
                    print(value);
                  });
                }
              }),
          RadioListTile<String>(
              title: Text(LocaleKeys.moveToDone.tr()),
              value: isDone,
              groupValue: _taskStatue,
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    _taskStatue = value;
                    print(value);
                  });
                }
              }),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () async => await performUpdate(),
            child: Text(LocaleKeys.save.tr()),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(0, 50),
              primary: Colors.blueGrey,
              elevation: 10,
            ),
          )
        ],
      ),
    );
  }

  Future<void> performUpdate() async {
    if (checkData()) {
      await update();
    }
  }

  bool checkData() {
    if (_taskTextController.text.isNotEmpty &&
        _detailsTaskTextController.text.isNotEmpty) {
      return true;
    }
    //SNACKBAR
    showSnackBar(
        context: context, message: LocaleKeys.enterRequireData.tr(), error: true);
    return false;
  }

  Future<void> update() async {
    bool updated =
        await Provider.of<TasksProvider>(context, listen: false).update(task);
    String message = updated ? LocaleKeys.successfullyUpdate.tr() : LocaleKeys.failedUpdate.tr();
    showSnackBar(context: context, message: message, error: !updated);
    if (updated) Navigator.pop(context);
  }

  Tasks get task {
    Tasks c = widget.tasks;
    c.taskName = _taskTextController.text;
    c.taskState = _taskStatue;
    c.taskDescription = _detailsTaskTextController.text;
    return c;
  }
}
