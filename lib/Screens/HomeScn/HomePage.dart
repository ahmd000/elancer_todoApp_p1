import 'package:elancer_todo_p1/Provider/GoogleSignInProvider.dart';
import 'package:elancer_todo_p1/Provider/TasksProvider.dart';
import 'package:elancer_todo_p1/Screens/HomeScn/ScreensNavBar/AddNewTasksScreen.dart';
import 'package:elancer_todo_p1/Screens/HomeScn/ScreensNavBar/ProfileScreen.dart';
import 'package:elancer_todo_p1/Screens/HomeScn/ScreensNavBar/TasksScreen.dart';
import 'package:elancer_todo_p1/translations/locale_key.g.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:elancer_todo_p1/helpers/helpers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Helpers {
  User? user = FirebaseAuth.instance.currentUser;
  int _selectedIndex = 1;
  bool isLoading = false;
  static TextStyle HomeNavbarPage =
      GoogleFonts.rubik(fontSize: 30.sp, fontWeight: FontWeight.w600);
  List<Widget> _widgetOptions = <Widget>[
    AddNewTasksScreen(
      tasks: null,
    ),
    TasksScreen(),
    ProfileScreen(),
  ];

  static List<Widget> _widgetNames = <Widget>[
    Text(
      LocaleKeys.addTask.tr(),
      style: HomeNavbarPage,
    ),
    Text(
      LocaleKeys.taskList.tr(),
      style: HomeNavbarPage,
    ),
    Text(
      LocaleKeys.profile.tr(),

      style: HomeNavbarPage,
    ),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(user!.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.info),
          onPressed: () {
            Navigator.pushNamed(context, "/info_Screen");
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                _selectLanguageAdmin(context);
              },
              icon: Icon(Icons.language)),
          IconButton(
              onPressed: () async {
                // setState(() {
                //   isLoading = true;
                // });
                FirebaseService service = new FirebaseService();
                try {
                  await service.signOutFromGoogle();
                  Navigator.pushReplacementNamed(
                    context,
                    "/login_scn",
                  );
                } catch (e) {
                  if (e is FirebaseAuthException) {
                    showMessage(e.message!);
                  }
                }
                // setState(() {
                //   isLoading = false;
                // });
              },
              icon: Icon(Icons.logout)),
        ],
        elevation: 20,
        centerTitle: true,
        title: _widgetNames.elementAt(_selectedIndex),
      ),
      body: isLoading == false
          ? Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              hoverColor: Colors.blueGrey[200]!,
              gap: 8,
              activeColor: Colors.blueGrey.shade800,
              color: Colors.blueGrey.shade300,
              // backgroundColor: Colors.blueGrey.shade900,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              iconSize: 24.sp,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.blueGrey.shade300,
              tabs: [
                GButton(
                  icon: Icons.add,
                  text: LocaleKeys.addTask.tr(),
                ),
                GButton(
                  icon: Icons.task,
                  text: LocaleKeys.taskList.tr(),
                ),
                GButton(
                  icon: Icons.person,
                  text: LocaleKeys.profile.tr(),
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  void showMessage(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(message),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  _selectLanguageAdmin(mContext) {
    double widthScn = MediaQuery.of(context).size.width;
    return showDialog(
        context: mContext,
        builder: (c) {
          return SimpleDialog(
            title: Text(
              LocaleKeys.slc_lan.tr(),
              textAlign: TextAlign.center,
              style: GoogleFonts.lateef(
                color: Colors.blue[700],
                fontSize: 30,
              ),
            ),
            children: [
              SimpleDialogOption(
                child: Text(
                  'English',
                  style: GoogleFonts.lateef(
                    color: Colors.blue,
                    fontSize: widthScn * 0.05,
                  ),
                ),
                onPressed: () async {
                  Navigator.pop(context);
                  await context.setLocale(Locale('en'));
                },
              ),
              SimpleDialogOption(
                child: Text(
                  'عربي',
                  style: GoogleFonts.lateef(
                    color: Colors.blue,
                    fontSize: 18.sp,
                  ),
                ),
                onPressed: () async {
                  Navigator.pop(context);

                  await context.setLocale(Locale('ar'));
                },
              ),
              SimpleDialogOption(
                child: Text(
                  LocaleKeys.cancel.tr(),
                  style: GoogleFonts.lateef(
                    color: Colors.redAccent,
                    fontSize: 25,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
