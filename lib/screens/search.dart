import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pimo/constants/Theme.dart';
import 'package:pimo/constants/Images.dart';
import 'package:pimo/screens/search_result.dart';

// widgets
import 'package:pimo/widgets/navbar.dart';
import 'package:pimo/widgets/home_view.dart';
import 'package:pimo/widgets/card-small.dart';
import 'package:pimo/widgets/table-cell.dart';

//screens
import 'package:pimo/screens/product.dart';
import 'package:pimo/screens/categories.dart';
import 'package:intl/intl.dart';
import 'package:pimo/screens/best-deals.dart';

import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final nameController = TextEditingController();
  final openController = TextEditingController();
  final closeController = TextEditingController();
  Future<List> getAllStyles() async {
    final response =
        await http.get(Uri.parse('https://api.pimo.studio/api/v1/styles'));
    if (response.statusCode == 200) {
      var test = json.decode(response.body);
      return test["style"];
    } else {
      throw Exception('Failed to load album');
    }
  }

  DateTime _selectedDate;
  String name = "";
  String openTime = "";
  String closeTime = "";
  List sexList = [
    {"id": 1, "name": 'Nam'},
    {"id": 2, "name": 'Nữ'},
    {"id": 3, "name": 'Khác'},
  ];

  List<int> selectedGenders = List();
  List<int> selectedStyles = List();
  void dispose() {
    nameController.dispose();
    openController.dispose();
    closeController.dispose();
    super.dispose();
  }

  bool isChecked = false;
  Future<List> getListStyles;
  @override
  Widget build(BuildContext context) {
    getListStyles = getAllStyles();
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.black,
          ),
          backgroundColor: MaterialColors.mainColor,
          elevation: 0,
          title: const Text(
            'Tìm kiếm Chiến dịch',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: MaterialColors.bgColorScreen,
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: MaterialColors.mainColor.withOpacity(0.5),
                    offset: Offset(0, 5),
                    blurRadius: 10,
                  )
                ]),
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Container(
                            child: Wrap(
                              direction: Axis.horizontal,
                              children: <Widget>[
                                const Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text("Tên sự kiện"),
                                ),
                                TextField(
                                    controller: nameController,
                                    onChanged: (newText) {
                                      setState(() {
                                        name = newText;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: 'Nhập tên sự kiện',
                                    )),
                                const Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text("Thời gian bắt đầu"),
                                ),
                                TextField(
                                  readOnly: true,
                                  onChanged: (newText) {
                                    setState(() {
                                      openTime = newText;
                                    });
                                  },
                                  controller: openController,
                                  onTap: () {
                                    _selectOpenDate(context);
                                  },
                                  decoration: const InputDecoration(
                                    suffixIcon: Icon(Icons.schedule),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text("Thời gian kết thúc"),
                                ),
                                TextField(
                                  readOnly: true,
                                  controller: closeController,
                                  onTap: () {
                                    _selectCloseDate(context);
                                  },
                                  decoration: const InputDecoration(
                                    suffixIcon: Icon(Icons.schedule),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text("Giới tính"),
                                ),
                                ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: sexList.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) => Row(
                                    children: [
                                      Checkbox(
                                        checkColor: Colors.white,
                                        fillColor:
                                            MaterialStateProperty.all<Color>(
                                                MaterialColors.mainColor),
                                        value: isChecked,
                                        onChanged: (bool value) {
                                          setState(() {
                                            isChecked = value;
                                          });
                                        },
                                      ),
                                      Text(sexList[index]["name"])
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text("Phong cách"),
                                ),
                                Column(
                                  children: <Widget>[
                                    FutureBuilder<List>(
                                        future: getAllStyles(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            List list1 = snapshot.data
                                                .getRange(0,
                                                    snapshot.data.length ~/ 2)
                                                .toList();
                                            List list2 = snapshot.data
                                                .getRange(
                                                    snapshot.data.length ~/ 2,
                                                    snapshot.data.length)
                                                .toList();
                                            return Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    shrinkWrap: true,
                                                    itemCount: list1.length,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        (context, index) => Row(
                                                      children: [
                                                        Checkbox(
                                                          checkColor:
                                                              Colors.white,
                                                          fillColor:
                                                              MaterialStateProperty.all<
                                                                      Color>(
                                                                  MaterialColors
                                                                      .mainColor),
                                                          value: isChecked,
                                                          onChanged:
                                                              (bool value) {
                                                            print(value);
                                                            setState(() {
                                                              isChecked = value;
                                                            });
                                                          },
                                                        ),
                                                        Text(list1[index]
                                                            ["name"])
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    shrinkWrap: true,
                                                    itemCount: list2.length,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        (context, index) => Row(
                                                      children: [
                                                        Checkbox(
                                                          checkColor:
                                                              Colors.white,
                                                          fillColor:
                                                              MaterialStateProperty.all<
                                                                      Color>(
                                                                  MaterialColors
                                                                      .mainColor),
                                                          value: isChecked,
                                                          onChanged:
                                                              (bool value) {
                                                            print(value);
                                                            setState(() {
                                                              isChecked = value;
                                                            });
                                                          },
                                                        ),
                                                        Text(list2[index]
                                                            ["name"])
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            );
                                          } else {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }
                                        })
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: RaisedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SearchResult(
                                                        name: name,
                                                        openDate: openTime,
                                                        closeDate: closeTime,
                                                      )));
                                        },
                                        textColor: Colors.white,
                                        color: MaterialColors.mainColor,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 16.0),
                                        child: const Text("Tìm kiếm",
                                            style: TextStyle(fontSize: 16))),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: RaisedButton(
                                        onPressed: () {
                                          setState(() {
                                            name = "";
                                            closeTime = "";
                                            openTime = "";
                                          });
                                        },
                                        textColor: Colors.white,
                                        color: MaterialColors.mainColor,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 16.0),
                                        child: const Text("Huỷ",
                                            style: TextStyle(fontSize: 16))),
                                  ),
                                )
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ])));
  }

  _selectOpenDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                surface: Colors.blueGrey,
                onSurface: Colors.yellow,
              ),
              dialogBackgroundColor: Colors.blue[500],
            ),
            child: child,
          );
        });

    if (newSelectedDate != null) {
      setState(() {
        _selectedDate = newSelectedDate;
      });
      openController
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: openController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  _selectCloseDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                surface: Colors.blueGrey,
                onSurface: Colors.yellow,
              ),
              dialogBackgroundColor: Colors.blue[500],
            ),
            child: child,
          );
        });

    if (newSelectedDate != null) {
      setState(() {
        _selectedDate = newSelectedDate;
      });
      closeController
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: closeController.text.length,
            affinity: TextAffinity.upstream));
    }
  }
}
