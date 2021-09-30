import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pimo/constants/Theme.dart';
import 'package:pimo/constants/Theme.dart';
import 'package:pimo/utils/google_sign_in.dart';
import 'package:provider/provider.dart';

class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/img/background.jpg"),
                  fit: BoxFit.cover))),
      Padding(
        padding: const EdgeInsets.only(left: 32, right: 30, bottom: 16),
        child: Container(
          padding: EdgeInsets.only(bottom: 40),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.pinkAccent,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    width: double.infinity,
                    child: FlatButton(
                      textColor: Colors.pinkAccent,
                      color: Colors.white,
                      onPressed: () {
                        //setup firebase
                        final provider =
                                Provider.of<GoogleSignInProvider>(context, listen: false);
                         provider.googleLogin();
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 60.0, right: 16.0, top: 12, bottom: 12),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "assets/img/logo.png",
                                height: 30,
                                width: 30,
                              ),
                              const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text("LOGIN WITH GOOGLE",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0)),
                              )
                            ]),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    ]));
  }
}
