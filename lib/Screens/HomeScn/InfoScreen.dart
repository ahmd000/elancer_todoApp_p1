import 'package:elancer_todo_p1/translations/locale_key.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ScreensNavBar/ProvileWidgets/ContactInformation.dart';
import 'ScreensNavBar/ProvileWidgets/ManagerInfo.dart';
import 'ScreensNavBar/ProvileWidgets/aboutMeInfo.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.info.tr()),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              ManagerInformation(),
              SizedBox(
                height: 13.h,
              ),

              Container(
                alignment: AlignmentDirectional.centerStart,
                padding: EdgeInsets.symmetric(
                  horizontal: 10.h,
                  vertical: 10.w,
                ),
                child: Expanded(
                  child: Column(
                    children: [
                      Text(
                        LocaleKeys.aboutUs.tr(),
                        textAlign: TextAlign.start,
                        style: GoogleFonts.rubik(
                            fontSize: 15.sp,
                            color: Color(0xff778CA2),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 13.h,
                      ),
                      AboutMeInfo(),


                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 13.h,
              ),
              ContactInformation(),
            ],
          ),
        ],
      ),
    );
  }
}
