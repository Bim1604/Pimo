import 'dart:ui';
import 'package:flutter/material.dart';
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
            padding: const EdgeInsets.only(left: 70, right: 45, bottom: 16),
            child: Container(
              padding: EdgeInsets.only(bottom: 30),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      //Chỉnh khung
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.pinkAccent,
                            width: 2.5,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        width: 230,
                        child: FlatButton(
                          textColor: Colors.pinkAccent,
                          color: Colors.white,
                          onPressed: () {
                            //setup firebase
                            final provider =
                            Provider.of<GoogleSignInProvider>(context, listen: false);
                            provider.googleLogin();
                            //Khi có context ở đây nó sẽ truyền qua authentication.
                            Navigator.pushReplacementNamed(context, '/authentication');
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10, top: 8, bottom: 8),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    "assets/img/logo.png",
                                    height: 30,
                                    width: 30,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: Text("LOGIN WITH GOOGLE",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13.0)),
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
