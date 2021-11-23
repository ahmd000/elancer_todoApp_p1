import 'package:elancer_todo_p1/translations/locale_key.g.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Constanse/Constanse.dart';
import 'package:easy_localization/easy_localization.dart';

class OverboardScreen extends StatefulWidget {
  const OverboardScreen({Key? key}) : super(key: key);

  @override
  _OverboardScreenState createState() => _OverboardScreenState();
}

class _OverboardScreenState extends State<OverboardScreen> {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: OverBoard(
        pages: pages,
        showBullets: true,
        finishText: LocaleKeys.start.tr(),
        nextText: LocaleKeys.next.tr(),
        skipText: LocaleKeys.skip.tr(),
        skipCallback: () {
          if (user == null) {
            Navigator.pushReplacementNamed(context, "/login_scn");
          } else {
            Navigator.pushReplacementNamed(context, "/home_scn");
          }
        },
        finishCallback: () {
          if (user == null) {
            Navigator.pushReplacementNamed(context, "/login_scn");
          } else {
            Navigator.pushReplacementNamed(context, "/home_scn");
          }        },
      ),
    );
  }

  final pages = [
    PageModel(
      color: Colors.blueGrey,
      imageAssetPath: border1,
      title: LocaleKeys.app_name.tr(),
      body: LocaleKeys.borderDetail1.tr(),
      doAnimateImage: true,
    ),
    PageModel(
      color: Colors.blueGrey,
      imageAssetPath: border2,
      title: LocaleKeys.app_name.tr(),
      body: LocaleKeys.borderDetail2.tr(),
      doAnimateImage: true,
    ),
    PageModel.withChild(
      child: Padding(
        padding: EdgeInsets.only(bottom: 25.0),
        child: Image.asset(border3, width: 300.0, height: 300.0),
      ),
      color: Colors.blueGrey,
      doAnimateChild: true,
    )
  ];
}
