import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:elancer_todo_p1/Constanse/Constanse.dart';
import 'package:elancer_todo_p1/Model/Tasks.dart';
import 'package:elancer_todo_p1/Provider/TasksProvider.dart';
import 'package:elancer_todo_p1/Widgets/app_text_field.dart';
import 'package:elancer_todo_p1/helpers/helpers.dart';
import 'package:elancer_todo_p1/translations/locale_key.g.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNewTasksScreen extends StatefulWidget {
  const AddNewTasksScreen({Key? key, required this.tasks , this.title = "create"}) : super(key: key);
  final String title;
  final Tasks? tasks ;

  @override
  _AddNewTasksScreenState createState() => _AddNewTasksScreenState();
}

class _AddNewTasksScreenState extends State<AddNewTasksScreen> with Helpers {
  late TextEditingController _taskTextController;
  late TextEditingController _detailsTaskTextController;

  DateTime selectedDate = DateTime.now();
  List<String> _tagTasks = <String>[];
User? user = FirebaseAuth.instance.currentUser;
  String _taskState = isActive;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _taskTextController = TextEditingController();
    _detailsTaskTextController = TextEditingController();
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
      resizeToAvoidBottomInset: true,
      body: ListView(
        // physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          Text(
            LocaleKeys.addNewTask.tr(),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _selectDate(context);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(0, 50),
                  primary: Colors.blueGrey.shade600,
                  elevation: 5,
                ),
                child: Text(LocaleKeys.enterDate.tr()),
              ),
              Text(
                  "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
            ],
          ),
          const SizedBox(height: 10),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () async => await performCreate(),
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

  void deleteTags({required String targetTag}) {
    setState(() {
      bool deleted = _tagTasks.remove(targetTag);
    });
  }



  Future<void> performCreate() async {
    if (checkData()) {
      await create();
    }
  }

  bool checkData() {
    if (_taskTextController.text.isNotEmpty &&
        _detailsTaskTextController.text.isNotEmpty) {
      return true;
    } else {
      showSnackBar(
        context: context,
        message: LocaleKeys.enterRequireData.tr(),
        error: true,
      );
      return false;
    }
  }

  Future<void> create() async {
    bool created = await Provider.of<TasksProvider>(context, listen: false)
        .create(taskDetail);
    String message = created
        ? LocaleKeys.successfullyAdded.tr()
        : LocaleKeys.fieldAdded.tr();
    showSnackBar(context: context, message: message, error: !created);
    if (created) {
      clear();
    }
  }

  Tasks get taskDetail {
    Tasks c = Tasks();
    c.taskName = _taskTextController.text;
    c.taskDescription = _detailsTaskTextController.text;
    c.taskState = _taskState;
    c.email = user!.email!;
    c.finalDateTask = selectedDate.toString();
    return c;
  }

  void clear() {
    _taskTextController.text = '';
    _detailsTaskTextController.text = '';
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      cancelText: LocaleKeys.cancel.tr(),
      lastDate: DateTime(2030),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
      });
  }
}
