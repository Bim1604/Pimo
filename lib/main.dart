import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pimo/screens/authentication.dart';
import 'package:pimo/screens/home.dart';
import 'package:pimo/screens/man.dart';
import 'package:pimo/screens/onboarding.dart';
import 'package:pimo/screens/woman.dart';
import 'package:pimo/utils/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:pimo/screens/new-collection.dart';
import 'package:pimo/screens/profile.dart';
import 'package:pimo/screens/settings.dart';
import 'package:pimo/screens/components.dart';
import 'package:pimo/screens/onboarding.dart';
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
          title: "Model Booking",
          debugShowCheckedModeBanner: false,
          initialRoute: "/onboarding",
          routes: <String, WidgetBuilder>{
            "/onboarding": (BuildContext context) => new Onboarding(),
            "/home": (BuildContext context) => new MyHomePage(),
            "/authentication": (BuildContext context) => new HomeAuthentication(),
            "/woman": (BuildContext context) => new Woman(),
            "/components": (BuildContext context) => new Components(),
            "/newcollection": (BuildContext context) => new NewCollection(),
            "/profile": (BuildContext context) => new Profile(),
            "/settings": (BuildContext context) => new Settings(),
          }),
    );
  }
}
