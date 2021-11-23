import 'package:elancer_todo_p1/Constanse/Constanse.dart';
import 'package:elancer_todo_p1/translations/locale_key.g.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'ProvileWidgets/ContactInformation.dart';
import 'ProvileWidgets/aboutMeInfo.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,

        padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 15.w),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bcg_profile),
              fit: BoxFit.cover,
            )),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: double.infinity,
              child: Text(
                LocaleKeys.card_manager.tr(),
                style: GoogleFonts.rubik(
                  fontSize: 23.sp,
                  color: Color(0xff778CA2),
                ),
              ),
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(user!.photoURL!),
              radius: 70,
            ),
            SizedBox(
              height: 14.h,
            ),
            Text(
              "${user!.displayName}",
              style: GoogleFonts.rubik(
                fontSize: 18.sp,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              "${user!.email}",
              style: GoogleFonts.rubik(
                fontSize: 14.sp,
                color: Color(0xff778CA2),
              ),
            ),
            SizedBox(
              height: 32.h,
            ),
          ],
        ),
      ),
    );
  }

}
