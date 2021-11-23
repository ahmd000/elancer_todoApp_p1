import 'dart:math';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:elancer_todo_p1/Constanse/Constanse.dart';
import 'package:elancer_todo_p1/Screens/HomeScn/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elancer_todo_p1/translations/locale_key.g.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'OverboardScreen.dart';
import 'Provider/TasksProvider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 38, bottom: 250),
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
              logo,
            ),
            fit: BoxFit.cover,
            // scale: 658,
            alignment: Alignment(-1, -308),
          )),
          child: AnimatedSplashScreen(
            duration: 3000,
            backgroundColor: Colors.transparent,
            nextScreen: OverboardScreen(),
            splashTransition: SplashTransition.fadeTransition,
            animationDuration: Duration(seconds: 1),
            pageTransitionType: PageTransitionType.fade, splash: null,
            // pageTransitionType: PageTransitionType.scale,
          ),
        ),
      ),
    );
  }
}
