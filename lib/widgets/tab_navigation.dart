import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pimo/screens/cart.dart';
import 'package:pimo/screens/home.dart';
import 'package:pimo/screens/test.dart';
import 'package:provider/provider.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem});

  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (tabItem == "Page1")
      child = Page1();
    else if (tabItem == "Page2")
      child = Page2();
    else if (tabItem == "Page3")
      child = Page3();
    else if (tabItem == "Page4")
      child = Page4();
    else if (tabItem == "Page5") child = Page5();

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScreen();
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pinkAccent,
    );
  }
}


class Page3 extends StatelessWidget {
  const Page3({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
    );
  }
}

class Page4 extends StatelessWidget {
  const Page4({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyan
    );
  }
}

class Page5 extends StatelessWidget {
  const Page5({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white54,
    );
  }
}



