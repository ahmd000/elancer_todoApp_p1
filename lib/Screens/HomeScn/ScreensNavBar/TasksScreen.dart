import 'package:elancer_todo_p1/translations/locale_key.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'TabBarScreens/IsActiveScreen.dart';
import 'TabBarScreens/IsDoneScreen.dart';
import 'TabBarScreens/IsProgressScreen.dart';
import 'package:easy_localization/easy_localization.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TabBar(
              labelColor: Color(0xFF4D7CFE),
              labelStyle: GoogleFonts.rubik(
                  fontSize: 12.sp, fontWeight: FontWeight.w700),
              unselectedLabelStyle: GoogleFonts.rubik(
                fontSize: 12.sp,
              ),
              indicatorColor: Colors.black,
              controller: _tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              tabs: [
                Tab(
                    child: Text(
                  LocaleKeys.activeTask.tr(),
                  textAlign: TextAlign.center,
                )),
                Tab(
                    child: Text(
                      LocaleKeys.progressTask.tr(),
                  // 'Tasks Progress',
                  textAlign: TextAlign.center,
                )),
                Tab(
                    child: Text(
                  LocaleKeys.doneTask.tr(),
                  // 'Tasks Done',
                  textAlign: TextAlign.center,
                )),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                IsActiveScreen(),
                IsProgressScreen(),
                IsDoneScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
