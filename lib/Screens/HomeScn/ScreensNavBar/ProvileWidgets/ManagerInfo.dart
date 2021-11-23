import 'package:elancer_todo_p1/Constanse/Constanse.dart';
import 'package:elancer_todo_p1/translations/locale_key.g.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

Container ManagerInformation() {
  return Container(
    height: 350.h,
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 15.w),
    decoration: BoxDecoration(
        gradient: LinearGradient(
            tileMode: TileMode.mirror,
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
            colors: [
          Colors.blueGrey.shade400,
          Colors.white70,
          Colors.blueGrey.shade400,
          Colors.white70,
        ])),
    // image: DecorationImage(
    //   image: AssetImage(bac_info),
    //   fit: BoxFit.cover,
    // ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(my_photo),
          radius: 70,
        ),
        SizedBox(
          height: 14.h,
        ),
        Text(
          LocaleKeys.name.tr(),
          style: GoogleFonts.rubik(
            fontSize: 18.sp,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        Text(
          email,
          style: GoogleFonts.rubik(
            fontSize: 14.sp,
            color: Color(0xff778CA2),
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        Text(
          jobTitle,
          style: GoogleFonts.rubik(
            fontSize: 14.sp,
            color: Color(0xff778CA2),
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
      ],
    ),
  );
}
