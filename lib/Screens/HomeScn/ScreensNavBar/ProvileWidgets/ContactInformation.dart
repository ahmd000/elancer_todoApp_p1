import 'package:elancer_todo_p1/Constanse/Constanse.dart';
import 'package:elancer_todo_p1/translations/locale_key.g.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

Container ContactInformation() {
  User? user = FirebaseAuth.instance.currentUser;

  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 17.sp),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(15)),
    child: Column(
      children: [
        Container(
          child: Text(
            LocaleKeys.contact_detail.tr(),
            style: GoogleFonts.rubik(
                fontSize: 15.sp,
                color: Color(0xff778CA2),
                fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          // onTap: () async {
          //   if (!await launch(email)) throw 'Could not launch $email';
          // },
          title: Text(
            LocaleKeys.email.tr(),
            style: GoogleFonts.rubik(
              fontSize: 14.sp,
              color: Color(0xff778CA2),
            ),
          ),
          subtitle: Text(
            email,
            style: GoogleFonts.rubik(
              fontSize: 14.sp,
              color: Colors.black,
            ),
          ),
          leading: Icon(
            Icons.alternate_email,
            color: Color(0xff778CA2),
            size: 20.sp,
          ),
        ),
        Divider(
          color: Color(0xffD8D8D8),
        ),
        ListTile(
          // onTap: () async {
          //   if (!await launch(phone)) throw 'Could not launch $phone';
          // },
          title: Text(
            LocaleKeys.phone.tr(),
            style: GoogleFonts.rubik(
              fontSize: 14.sp,
              color: Color(0xff778CA2),
            ),
          ),
          subtitle: Text(
            phone,
            style: GoogleFonts.rubik(
              fontSize: 14.sp,
              color: Colors.black,
            ),
          ),
          leading: Icon(
            Icons.phone,
            color: Color(0xff778CA2),
            size: 20.sp,
          ),
        ),
        Divider(
          color: Color(0xffD8D8D8),
        ),
        ListTile(
          title: Text(
            LocaleKeys.address.tr(),
            style: GoogleFonts.rubik(
              fontSize: 14.sp,
              color: Color(0xff778CA2),
            ),
          ),
          subtitle: Text(
            LocaleKeys.address_detail.tr(),
            style: GoogleFonts.rubik(
              fontSize: 14.sp,
              color: Colors.black,
            ),
          ),
          leading: Icon(
            Icons.location_city,
            color: Color(0xff778CA2),
            size: 20.sp,
          ),
        ),
        Divider(
          color: Color(0xffD8D8D8),
        ),
      ],
    ),
  );
}
