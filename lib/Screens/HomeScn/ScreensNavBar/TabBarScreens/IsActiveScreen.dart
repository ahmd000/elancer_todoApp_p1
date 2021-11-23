import 'package:elancer_todo_p1/Constanse/Constanse.dart';
import 'package:elancer_todo_p1/Model/Tasks.dart';
import 'package:elancer_todo_p1/Provider/TasksProvider.dart';
import 'package:elancer_todo_p1/Screens/HomeScn/UpdateScreen.dart';
import 'package:elancer_todo_p1/helpers/helpers.dart';
import 'package:elancer_todo_p1/translations/locale_key.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import '../AddNewTasksScreen.dart';

class IsActiveScreen extends StatefulWidget {
   IsActiveScreen({Key? key } ) : super(key: key);


  @override
  _IsActiveScreenState createState() => _IsActiveScreenState();
}

class _IsActiveScreenState extends State<IsActiveScreen> with Helpers {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TasksProvider>(context, listen: false).read();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      body: Consumer<TasksProvider>(
        builder: (BuildContext context, TasksProvider value, child) {
          if (value.tasks.isNotEmpty) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 20.h,
              ),
              itemCount: value.tasks
                  .where((element) => element.taskState == isActive)
                  .length,
              itemBuilder: (context, index) {
                return Slidable(
                  key: const ValueKey(0),
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    // dismissible: DismissiblePane(onDismissed: () {}),
                    children: [
                      SlidableAction(
                        flex: 2,
                        backgroundColor: Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: LocaleKeys.delete.tr(),
                        onPressed: (_) => delete(value.tasks[index].id),
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        flex: 2,
                        onPressed: (_) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateScreen(
                                tasks: value.tasks[index],
                                title: 'Update',
                              ),
                            ),
                          );
                        },
                        backgroundColor: Color(0xFF7BC043),
                        foregroundColor: Colors.white,
                        icon: Icons.move_to_inbox,
                      label: LocaleKeys.update.tr(),

                ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          onTap: () {
                            showDetailDialog(value.tasks[index]);




                          },
                          leading: Icon(
                            Icons.task_alt_sharp,
                            color: Color(0xFF7BC043),
                          ),
                          title: Text(
                            value.tasks[index].taskName,
                            style: GoogleFonts.rubik(
                              fontSize: 18.sp,
                              color: Color(0xff252631),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      )
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                Image.asset(noTask),
                  Text(
                    LocaleKeys.dataEmpty.tr(),
                    style: GoogleFonts.rubik(
                      fontSize: 22.sp,
                      color: Colors.grey.shade400,
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> showDetailDialog(Tasks task) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            task.taskName,
            style: GoogleFonts.rubik(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Color(0xff252631),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Expanded(
                  child: Text(
                    task.taskDescription,
                    style: GoogleFonts.rubik(
                      fontSize: 18.sp,
                      color: Color(0xff252631),
                    ),
                  ),
                ),


                Text(task.taskState),


                Text(
                  task.finalDateTask,
                  style: GoogleFonts.rubik(
                    fontSize: 18.sp,
                    color: Color(0xff252631),
                  ),
                ),
    Text(
                  task.email,
                  style: GoogleFonts.rubik(
                    fontSize: 18.sp,
                    color: Color(0xff252631),
                  ),
                ),

              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(LocaleKeys.ok.tr()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> delete(int id) async {
    bool deleted =
        await Provider.of<TasksProvider>(context, listen: false).delete(id);
    String message =
        deleted ? LocaleKeys.deleteSuccess.tr() : LocaleKeys.deleteFailed.tr();
    showSnackBar(context: context, message: message, error: !deleted);
  }
}
