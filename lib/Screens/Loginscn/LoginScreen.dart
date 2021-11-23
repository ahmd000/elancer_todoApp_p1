import 'dart:io';

import 'package:elancer_todo_p1/Constanse/Constanse.dart';
import 'package:elancer_todo_p1/Provider/GoogleSignInProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: AspectRatio(
                aspectRatio: 2 / 3,
                child: Image.asset(
                  office,
                  fit: BoxFit.fitHeight,
                  width: 658,
                  height: 658,
                ),
              ),
            ),
            Positioned(
              left: 25.w,
              right: 25.w,
              bottom: 25.h,
              child: Material(
                elevation: 30,
                color: Colors.white54,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: Container(
                  height: 300.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: !isLoading
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "تسجيل الدخول ",
                              style: GoogleFonts.rubik(
                                  fontSize: 20.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                minimumSize: Size(0, 50),
                                elevation: 20,
                                backgroundColor: Colors.white54,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "تسجيل الدخول عبر جوجل",
                                    style: GoogleFonts.rubik(
                                        fontSize: 20.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Image.asset(googleLogin)
                                ],
                              ),
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                FirebaseService service = new FirebaseService();
                                try {
                                  await service.signInwithGoogle();
                                  Navigator.pushReplacementNamed(context, "/home_scn", );
                                } catch(e){
                                  if(e is FirebaseAuthException){
                                    showMessage(e.message!);
                                  }
                                }
                                setState(() {
                                  isLoading = false;
                                });
                              },
                            ),
                            Platform.isIOS
                                ? TextButton(
                                    style: TextButton.styleFrom(
                                      minimumSize: Size(0, 50),
                                      elevation: 20,
                                      backgroundColor: Colors.white54,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "تسجيل الدخول عبر ابل",
                                          style: GoogleFonts.rubik(
                                              fontSize: 20.sp,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Image.asset(googleLogin)
                                      ],
                                    ),
                                    onPressed: () {},
                                  )
                                : Container()
                          ],
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
              ),
            )
          ],
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
}
