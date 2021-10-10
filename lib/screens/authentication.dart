import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pimo/screens/home.dart';
import 'package:pimo/screens/onboarding.dart';
import 'package:flutter/cupertino.dart';
class HomeAuthentication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                return Home();
              } else if (snapshot.hasError) {
                return Center(child: Text('Something Went Wrong'));
              } else {
                print('Hello Onboaring');
                return Onboarding();
              }
            }));
  }
}
