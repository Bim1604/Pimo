import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:pimo/constants/Theme.dart';
import 'package:pimo/widgets/brands.dart';
import 'package:http/http.dart' as http;

//widgets
import 'package:pimo/widgets/navbar.dart';
import 'package:pimo/widgets/card-horizontal.dart';
import 'package:pimo/widgets/card-small.dart';
import 'package:pimo/widgets/card-square.dart';
import 'package:pimo/widgets/drawer.dart';

import 'package:pimo/screens/product.dart';

//Đây là nơi fetch API về
final Map<String, Map<String, String>> homeCards = {
  "Ice Cream": {
    "title": "Hardly Anything Takes More Coura...",
    "image":
    "https://i.pinimg.com/originals/55/55/8e/55558ea1bb1885d2925d15205b7b0b93.png",
    "price": "180"
  },
  "Makeup": {
    "title": "Find the cheapest deals on our range...",
    "image":
    "https://images.unsplash.com/photo-1515709980177-7a7d628c09ba?crop=entropy&w=840&h=840&fit=crop",
    "price": "220"
  },
  "Coffee": {
    "title": "Looking for Men's watches?",
    "image":
    "https://images.unsplash.com/photo-1490367532201-b9bc1dc483f6?crop=entropy&w=840&h=840&fit=crop",
    "price": "40"
  },
  "Fashion": {
    "title": "Curious Blossom Skin Care Kit.",
    "image":
    "https://images.unsplash.com/photo-1536303006682-2ee36ba49592?crop=entropy&w=840&h=840&fit=crop",
    "price": "188"
  },
  "Argon": {
    "title": "Adjust your watch to your outfit.",
    "image":
    "https://images.unsplash.com/photo-1491336477066-31156b5e4f35?crop=entropy&w=840&h=840&fit=crop",
    "price": "180"
  }
};

class Home extends StatelessWidget {
  // final GlobalKey _scaffoldKey = new GlobalKey();

  Future<Brands> fetchBrands() async {
    final response = await http
        .get(Uri.parse('https://api.pimo.studio/api/v1/castings/infomation/1'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print('Fetch Data JSON');
      return Brands.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<Brands> futureBrands;

  @override
  Widget build(BuildContext context) {
    futureBrands = fetchBrands();
    return Scaffold(
        appBar: Navbar(
          title: "Trang chủ",
          searchBar: true,
        ),
        backgroundColor: MaterialColors.bgColorScreen,
        // key: _scaffoldKey,
        // drawer: MaterialDrawer(currentPage: "Home"),
        body: FutureBuilder<Brands>(
          future: futureBrands,
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return Container(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(

                        padding: const EdgeInsets.only(top: 16.0),
                        child: CardHorizontal(
                            cta: "${snapshot.data.name}",
                            title: "${snapshot.data.description}",
                            img: homeCards["Ice Cream"]['image'],
                            tap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Product(
                                      title: homeCards["Ice Cream"]['title'],
                                      urlImg: homeCards["Ice Cream"]['image'],
                                    ),
                                  ));
                            }),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CardSmall(
                              cta: "View article",
                              title: homeCards["Makeup"]['title'],
                              img: homeCards["Makeup"]['image'],
                              tap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Product(
                                        title: homeCards["Makeup"]['title'],
                                        urlImg: homeCards["Makeup"]['image'],
                                      ),
                                    ));
                              }),
                          CardSmall(
                              cta: "View article",
                              title: homeCards["Coffee"]['title'],
                              img: homeCards["Coffee"]['image'],
                              tap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Product(
                                        title: homeCards["Coffee"]['title'],
                                        urlImg: homeCards["Coffee"]['image'],
                                      ),
                                    ));
                              })
                        ],
                      ),
                      SizedBox(height: 8.0),
                      CardHorizontal(
                          cta: "What do you see",
                          title: homeCards["Fashion"]['title'],
                          img: homeCards["Fashion"]['image'],
                          tap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Product(
                                    title: homeCards["Fashion"]['title'],
                                    urlImg: homeCards["Fashion"]['image'],
                                  ),
                                ));
                          }),
                      SizedBox(height: 8.0),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 32.0),
                        child: CardSquare(
                            cta: "View article",
                            title: homeCards["Argon"]['title'],
                            img: homeCards["Argon"]['image'],
                            tap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Product(
                                      title: homeCards["Argon"]['title'],
                                      urlImg: homeCards["Argon"]['image'],
                                    ),
                                  ));
                            }),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }
        ));
  }
}
