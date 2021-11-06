import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pimo/constants/Theme.dart';
import 'package:pimo/constants/Images.dart';

// widgets
import 'package:pimo/widgets/navbar.dart';
import 'package:pimo/widgets/home_view.dart';
import 'package:pimo/widgets/card-small.dart';
import 'package:pimo/widgets/table-cell.dart';

//screens
import 'package:pimo/screens/product.dart';
import 'package:pimo/screens/categories.dart';
import 'package:pimo/screens/best-deals.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;

class SearchResult extends StatelessWidget with ChangeNotifier {
  final String name;
  final String openDate;
  final String closeDate;
  SearchResult({this.name = "", this.closeDate = "2021-12-02", this.openDate = "2021-10-02"});

  List results = [];
  Future<List> fetchCasting(String name, String openTime, String closeTime) async {
    var now = DateTime.now();
    if(openTime.isEmpty){
      openTime = getFormattedDate(now.toString());
    }else{
      openTime = getFormattedDate(openTime);
    }
    if(closeTime.isEmpty){
      closeTime = getFormattedDate(now.toString());
    }else{
      closeTime = getFormattedDate(closeTime);
    }
    if(name.isEmpty){
      name = "";
    }
    final response =
        await http.get(Uri.parse(
          'https://api.pimo.studio/api/v1/castings?StartTime=${openTime}&EndTime=${closeTime}&Name=${name}'
          ));
    print(response.statusCode);
    if (response.statusCode == 200) {
      var test = json.decode(response.body);
      
      var b = test["castings"];
      return b;
    } else {
      throw Exception('Failed to load album');
    }
  }

  String getFormattedDate(String date) {
    var localDate = DateTime.parse(date).toLocal();

    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(localDate.toString());

    var outputFormat = DateFormat('HH:mm dd/MM/yyyy');
    var outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }

  Future<List> getEvents;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    getEvents = fetchCasting(name, openDate, closeDate);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.black,
          ),
          backgroundColor: MaterialColors.mainColor,
          elevation: 0,
          title: const Text(
            'Kết quả tìm kiếm',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FutureBuilder<List>(
                  future: getEvents,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List list = snapshot.data;
                      return Container(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: list.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) =>
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: CardHorizontal(
                                    title: "${list[index]["casting"]["name"]}",
                                    openTime: getFormattedDate(
                                        "${list[index]["casting"]["openTime"]}"),
                                    closeTime: getFormattedDate(
                                        "${list[index]["casting"]["closeTime"]}"),
                                    img: list[index]["casting"]["poster"],
                                    tap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Product(
                                              id: list[index]["casting"]["id"]
                                                  .toString(),
                                            ),
                                          ));
                                    }),
                              )),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
