import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pimo/constants/Images.dart';
import 'package:pimo/constants/Theme.dart';
import 'package:pimo/module/deprecated/flutter_session/flutter_session.dart';
import 'package:pimo/viewmodels/body_list_view_model.dart';
import 'package:pimo/viewmodels/model_view_model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'model_profile.dart';

class UpdateMeasureProfilePage extends StatefulWidget {
  final int modelId;
  UpdateMeasureProfilePage({Key key, this.modelId}) : super(key: key);
  @override
  _UpdateMeasureProfilePage createState() => _UpdateMeasureProfilePage();
}

class _UpdateMeasureProfilePage extends State<UpdateMeasureProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: MaterialColors.mainColor,
              title: Text('Sửa chi tiết cá nhân'),
            ),
            body: Row(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 0),
                        child: Text('hello'),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
