import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pimo/models/casting.dart';
import 'package:pimo/network/network_request.dart';
import 'package:pimo/screens/components.dart';
import 'package:pimo/screens/product.dart';
import 'package:pimo/widgets/home_view.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatelessWidget with ChangeNotifier {

  Future<CardHorizontal> fetchCasting() async {
    final response = await http
        .get(Uri.parse('https://api.pimo.studio/api/v1/castings/information/1'));
    if (response.statusCode == 200) {
      return CardHorizontal.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }


  Future<CardHorizontal> getEvents;

  String getFormattedDate(String date) {
    var localDate = DateTime.parse(date).toLocal();

    /// inputFormat - format getting from api or other func.
    /// e.g If 2021-05-27 9:34:12.781341 then format should be yyyy-MM-dd HH:mm
    /// If 27/05/2021 9:34:12.781341 then format should be dd/MM/yyyy HH:mm
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(localDate.toString());

    /// outputFormat - convert into format you want to show.
    var outputFormat = DateFormat('HH:mm dd/MM/yyyy');
    var outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }
  @override
  Widget build(BuildContext context) {
    Size size =
        MediaQuery
            .of(context)
            .size; //Total height and width of the screen
    var height = MediaQuery
        .of(context)
        .size
        .height;
    getEvents = fetchCasting();
    return SafeArea(
      child: FutureBuilder<CardHorizontal>(
          future: getEvents,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
                  body: SingleChildScrollView(
                    child: Column(children: <Widget>[
                      HeaderWithSearchBox(size: size),
                      const TitleWithButton(
                        text: "Upcoming Booking",
                        isBooking: true,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: CardHorizontal(
                            cta: "${snapshot.data.description}",
                            title: "${snapshot.data.name}",
                            openTime: getFormattedDate("${snapshot.data.openTime}"),
                            closeTime: getFormattedDate("${snapshot.data.closeTime}"),
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
                      const TitleWithButton(
                        text: "New Casting",
                      ),
                      CardHorizontal(
                          cta: "${snapshot.data.description}",
                          title: "${snapshot.data.name}",
                          openTime: getFormattedDate("${snapshot.data.openTime}"),
                          closeTime: getFormattedDate("${snapshot.data.closeTime}"),
                          img: homeCards["Makeup"]['image'],
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
                      // Casting(typeView: 2),
                      const TitleWithButton(
                        text: "Best for you",
                      ),
                      CardHorizontal(
                          cta: "${snapshot.data.description}",
                          title: "${snapshot.data.name}",
                          openTime: getFormattedDate("${snapshot.data.openTime}"),
                          closeTime: getFormattedDate("${snapshot.data.closeTime}"),
                          img: homeCards["Coffee"]['image'],
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
                      // Casting(typeView: 3),
                    ]),
                  ));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class HeaderWithSearchBox extends StatelessWidget {
  const HeaderWithSearchBox({Key key, @required this.size}) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: size.height * 0.2,
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              bottom: 36 + 20.0,
            ),
            height: size.height * 0.2 - 12,
            decoration: const BoxDecoration(
                color: Color(0xFFf5a6b9),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(36),
                    bottomRight: Radius.circular(36))),
            child: Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: SizedBox(
                      width: 300,
                      child: FutureBuilder(
                        // future: FlutterSession().get('modelName'),
                        builder: (context, snapshot) {
                          return Text(
                            'Hi ' + 'Lisa' + '!',
                            style:
                            Theme.of(context).textTheme.headline5.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                            ),
                          );
                        },
                      ),
                    )),
                const Spacer(),
                // Image.asset(name)
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                _showDialog(context);
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                height: 54,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: Color(0xFFf5a6b9).withOpacity(0.23))
                    ]),
                child: Row(
                  children: const <Widget>[
                    Icon(Icons.search),
                    SizedBox(
                      height: 5,
                      width: 20,
                    ),
                    Text(
                      'Search',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _showDialog(BuildContext context) {
  TextEditingController nameController, minController, maxController;
  nameController = TextEditingController()..text = '';
  minController = TextEditingController()..text = '';
  maxController = TextEditingController()..text = '';
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Search"),
        content: Builder(
          builder: (context) {
            // Get available height and width of the build area of this widget. Make a choice depending on the size.
            // var height = MediaQuery.of(context).size.height;
            // var width = MediaQuery.of(context).size.width;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 180,
              width: 350,
              child: ListView(
                children: [
                  TextFormField(
                    cursorColor: const Color(0xFFf5a6b9),
                    controller: nameController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.drive_file_rename_outline),
                      labelText: 'Name',
                    ),
                  ),
                  TextFormField(
                    cursorColor: Color(0xFFf5a6b9),
                    controller: minController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.drive_file_rename_outline),
                      labelText: 'Min salary',
                    ),
                  ),
                  TextFormField(
                    cursorColor: const Color(0xFFf5a6b9),
                    controller: maxController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.drive_file_rename_outline),
                      labelText: 'Max salary',
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.grey),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              elevation: 0,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: const Text(
              'Search',
              style: TextStyle(color: Color(0xFFf5a6b9)),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              elevation: 0,
            ), onPressed: () {  },
            // onPressed: () {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => MultiProvider(
            //             providers: [
            //               ChangeNotifierProvider(
            //                   create: (_) => CastingListViewModel()),
            //             ],
            //             child: FutureBuilder(
            //               builder: (context, snapshot) {
            //                 return SearchCastingPage(
            //                   name: nameController.text.toString(),
            //                   min: minController.text.toString(),
            //                   max: maxController.text.toString(),
            //                 );
            //               },
            //             ))),
            //   );
            // },
          ),
        ],
      );
    },
  );
}

class TitleWithButton extends StatelessWidget {
  const TitleWithButton({Key key, this.text, this.isBooking = false})
      : super(key: key);

  final String text;
  final bool isBooking;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(children: <Widget>[
        TitleWithCustomUnderline(
          text: text,
        ),
        Spacer(),
        FlatButton(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: const Color(0xFFf5a6b9),
            // onPressed: () {
            //   if (text == 'Notification') {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => NotificationPage(),
            //         ));
            //   } else {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => MultiProvider(
            //               providers: [
            //                 ChangeNotifierProvider(
            //                     create: (_) => CastingListViewModel()),
            //               ],
            //               child: FutureBuilder(
            //                 builder: (context, snapshot) {
            //                   return !isBooking
            //                       ? SearchCastingPage(
            //                     name: '',
            //                     min: '',
            //                     max: '',
            //                   )
            //                       : IncomingCastingPage();
            //                 },
            //               ))),
            //     );
            //   }
            // },
            child: const Text(
              'More',
              style: TextStyle(color: Colors.black),
            ))
      ]),
    );
  }
}

class TitleWithCustomUnderline extends StatelessWidget {
  const TitleWithCustomUnderline({Key key, this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0 / 4),
            child: Text(
              text,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.only(right: 20.0 / 4),
                height: 7,
                color: const Color(0xFFf5a6b9).withOpacity(0.2),
              ))
        ],
      ),
    );
  }
}