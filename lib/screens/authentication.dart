import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
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
                final LocalStorage storage = LocalStorage('localstorage_app');
                final role = storage.getItem('role');
                if (role == "Model") {
                  return Home();
                } else {
                  return Onboarding();
                }
              } else if (snapshot.hasError) {
                return Center(child: Text('Something Went Wrong'));
              } else {
                return Onboarding();
              }
            }));
  }
}
