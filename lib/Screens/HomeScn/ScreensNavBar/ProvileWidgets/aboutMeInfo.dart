import 'package:elancer_todo_p1/Constanse/Constanse.dart';
import 'package:elancer_todo_p1/translations/locale_key.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

Container AboutMeInfo() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 17.sp),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(15)),
    child: Column(
      children: [
        Text(
          LocaleKeys.bio.tr(),
          style: GoogleFonts.rubik(
            fontSize: 14.sp,
            color: Color(0xff778CA2),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: ()async {
                if (!await launch(facebookProfile)) throw 'Could not launch $facebookProfile';
              },
              child: CircleAvatar(
                backgroundImage: AssetImage(facebook_icon),
                backgroundColor: Color(0xffFFFFFF),
                radius: 20,
              ),
            ),
            InkWell(
              onTap: ()async {
                if (!await launch(linkedinProfile)) throw 'Could not launch $linkedinProfile';
              },
              child: CircleAvatar(
                backgroundImage: AssetImage(linkdine_icon),
                backgroundColor: Color(0xffFFFFFF),
                radius: 20,
              ),
            ),
            InkWell(
              onTap: ()async {
                // if (!await launch(linkedinProfile)) throw 'Could not launch $linkedinProfile';
              },
              child: CircleAvatar(
                backgroundImage: AssetImage(tweter_icon),
                backgroundColor: Color(0xffFFFFFF),
                radius: 20,
              ),
            ),
          ],
        )
      ],
    ),
  );
}
