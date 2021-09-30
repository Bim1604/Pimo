import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pimo/screens/authentication.dart';
import 'package:pimo/screens/home.dart';
import 'package:pimo/screens/onboarding.dart';
import 'package:pimo/utils/google_sign_in.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
          title: "Material Kit PRO Flutter",
          debugShowCheckedModeBanner: false,
          initialRoute: "/onboarding",
          routes: <String, WidgetBuilder>{
            "/onboarding": (BuildContext context) => new Onboarding(),
            "/home": (BuildContext context) => new Home(),
            "/authentication": (BuildContext context) => new HomeAuthentication(),
          }),
    );
  }
}
