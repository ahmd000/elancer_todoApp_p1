import 'package:easy_localization/easy_localization.dart';
import 'package:elancer_todo_p1/Model/Tasks.dart';
import 'package:elancer_todo_p1/Provider/GoogleSignInProvider.dart';
import 'package:elancer_todo_p1/Provider/TasksProvider.dart';
import 'package:elancer_todo_p1/Screens/HomeScn/HomePage.dart';
import 'package:elancer_todo_p1/Screens/HomeScn/UpdateScreen.dart';
import 'package:elancer_todo_p1/database/db_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'Screens/HomeScn/InfoScreen.dart';
import 'Screens/Loginscn/LoginScreen.dart';
import 'SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbController().initDatabase();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      startLocale: Locale("ar"),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(375, 812),
        builder: () {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<TasksProvider>(
                  create: (_) => TasksProvider()),
            ],
            child: MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              theme: ThemeData(primaryColor: Colors.blueGrey),
              debugShowCheckedModeBanner: false,
              initialRoute: "/splash_scn",
              routes: {
                "/splash_scn": (context) => SplashScreen(),
                "/home_scn": (context) => HomePage(),
                "/login_scn": (context) => LoginScreen(),
                "/info_Screen": (context) => InfoScreen(),
              },
            ),
          );
        });
  }
}
