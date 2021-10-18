import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pimo/screens/cart.dart';
import 'package:pimo/screens/home.dart';
import 'package:pimo/screens/home_page.dart';
import 'package:pimo/screens/model_image.dart';
import 'package:pimo/screens/model_profile.dart';
import 'package:pimo/screens/new_collection.dart';
import 'package:pimo/viewmodels/image_collection_list_view_model.dart';
import 'package:pimo/viewmodels/model_view_model.dart';
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
    return NewCollection();
  }
}


class Page3 extends StatelessWidget {
  const Page3({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ImageCollectionListViewModel()),
        ],
        child: FutureBuilder(
          //future: FlutterSession().get('modelId'),
          builder: (context, snapshot) {
            print("Model Image page");
            return ModelImagePage(
              modelId: snapshot.data.toString(),
            );
          },
        ));
  }
}

class Page4 extends StatelessWidget {
  const Page4({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ModelViewModel()),
          // ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
        ],
        child: FutureBuilder(
          // future: FlutterSession().get('modelId'),
          builder: (context, snapshot) {
            return ModelProfilePage(
              modelId: snapshot.data.toString(),
            );
          },
        ));
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



