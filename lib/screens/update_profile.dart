
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pimo/constants/Images.dart';
import 'package:pimo/constants/Theme.dart';
import 'package:pimo/module/deprecated/flutter_session/flutter_session.dart';
import 'package:pimo/services/model_services.dart';
import 'package:pimo/viewmodels/model_view_model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'model_profile.dart';

class UpdateModelProfilePage extends StatefulWidget {
  final int modelId;
  const UpdateModelProfilePage({Key key, this.modelId}) : super(key: key);

  @override
  _UpdateModelProfilePageState createState() => _UpdateModelProfilePageState();
}

class _UpdateModelProfilePageState extends State<UpdateModelProfilePage> {
  @override
  void initState() {
    super.initState();
    // PushNotificationService().init(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Chỉnh sửa thông tin',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: Center(
          child: FutureBuilder<ModelViewModel>(
            future: Provider.of<ModelViewModel>(context, listen: false)
                .getModel(widget.modelId),
            builder: (ctx, prevData) {
              if (prevData.connectionState == ConnectionState.waiting) {
                return Column(
                  children: <Widget>[
                    SizedBox(
                      height: 150,
                    ),
                    Center(child: CircularProgressIndicator()),
                  ],
                );
              } else {
                if (prevData.error == null) {
                  return ModelUpdate(
                      modelDetail:
                          Provider.of<ModelViewModel>(context, listen: false));
                } else {
                  return Text('Lỗi');
                }
              }
            },
          ),
        ),
      ),
    );
  }
}

class ModelUpdate extends StatefulWidget {
  final ModelViewModel modelDetail;
  const ModelUpdate({Key key, this.modelDetail}) : super(key: key);

  @override
  _ModelUpdateState createState() => _ModelUpdateState();
}

class _ModelUpdateState extends State<ModelUpdate> {
  DateTime _date;
  // int genderController;
  String genderController;
  TextEditingController nameController,
      dobController,
      phoneController,
      addressController,
      descriptionController,
      giftedController;

  GlobalKey<FormState> _profileKey = GlobalKey<FormState>();

  updateModelDetail(FormData params) async {
    // final message = jsonEncode(params);
    // print(message);
    var jwt = (await FlutterSession().get("jwt")).toString();
    var header = {
      'Content-Type': "multipart/form-data; boundary=xxBOUNDARYxx",
      'Accept': '*/*',
      'Authorization':
      "Bearer "+(jwt),
      'Access-Control-Allow-Origin': "*",
      'Access-Control-Allow-Methods': 'GET, POST, OPTIONS, PUT, PATCH, DELETE',
      'Access-Control-Allow-Headers': 'origin,X-Requested-With,content-type,accept',
      'Access-Control-Allow-Credentials': 'true'};
    // final response = await http.put(
    //     Uri.parse(url + 'api/v1/models'),
    //     body: message,
    //     // headers: {
    //     //   "Content-Type": "multipart/form-data; boundary=xxBOUNDARYxx",
    //     //   "Accept": "application/json",
    //     //   "Authorization": 'Bearer $jwt',
    //     // }
    //     headers: header,
    // );
    var dio = Dio();
    var response = await dio.request((url + 'api/v1/models'),
        options: Options(
          method: "PUT",
            headers: {
              'Content-Type': "multipart/form-data",
              "Authorization": 'Bearer $jwt',
          }),
        data: params,
    );
    print(response.statusCode);
    // print(response.body);
    try {
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Cập nhật thành công');
      } else {
        print(response.headers);
      }
    } on Exception catch (exception) {
      print("Exception: "+ exception.toString());
    } catch (error) {
      print("ERROR: " + error.toString());
    };

  }

  @override
  void dispose() {
    nameController.dispose();
    dobController.dispose();
    phoneController.dispose();
    addressController.dispose();
    // descriptionController.dispose();
    giftedController.dispose();
    super.dispose();
  }

  void _selectDate() async {
    final DateTime newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1190, 1),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.black,
              onPrimary: Colors.white,
              surface: MaterialColors.mainColor,
              onSurface: Colors.black,
              primaryVariant: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child,
        );
      },
    );
    if (newDate != null) {
      setState(() {
        _date = newDate;
        dobController = TextEditingController()
          ..text = formatDate(newDate.toString());
      });
    }
  }

  void _loadData() {
    nameController = TextEditingController()..text = widget.modelDetail.name;
    genderController  = widget.modelDetail.genderName;
    dobController = TextEditingController()
      ..text = formatDate(widget.modelDetail.dateOfBirth);
    // descriptionController = TextEditingController()..text = widget.modelDetail.description;
    phoneController = TextEditingController()..text = widget.modelDetail.phone;
    addressController = TextEditingController()
      ..text = widget.modelDetail.country;
    giftedController = TextEditingController()
      ..text = widget.modelDetail.gifted;
    _date = DateTime.parse(widget.modelDetail.dateOfBirth);

  }

  String formatDate(String date) {
    DateTime dt = DateTime.parse(date);
    // var formatter = new DateFormat('EEEE, dd MMM, yyyy');
    var formatter = new DateFormat('dd MMM, yyyy');
    return formatter.format(dt);
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _profileKey,
      child: Column(
        children: [
          Container(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(30),
              children: [
                TextFormField(
                  controller: nameController,
                  cursorColor: MaterialColors.mainColor,
                  decoration: InputDecoration(
                    icon: Icon(Icons.credit_card),
                    labelText: 'Tên',
                    // suffixIcon: Icon(
                    //   Icons.check_circle,
                    // ),
                  ),
                ),
                DropdownButtonFormField<String>(
                  value: genderController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.drive_file_rename_outline),
                    labelText: 'Giới tính',
                    // suffixIcon: Icon(
                    //   Icons.check_circle,
                    // ),
                  ),
                  items: [
                    DropdownMenuItem(
                      child: Text("Không rõ"),
                      value: null,
                    ),
                    DropdownMenuItem(
                      child: Text("Nam"),
                      value: "Nam",
                    ),
                    // DropdownMenuItem(
                    //   child: Text("Nam"),
                    //   value: "Nam",
                    // ),
                    // DropdownMenuItem(
                    //   child: Text("Nữ"),
                    //   value: "Nữ",
                    // )
                  ],
                  onChanged: (String value) {
                    setState(() {
                      genderController = value;
                    });
                  },
                ),
                GestureDetector(
                  onTap: _selectDate,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 260,
                        child: TextFormField(
                          controller: dobController,
                          cursorColor: MaterialColors.mainColor,
                          enabled: false,
                          decoration: InputDecoration(
                            icon: Icon(Icons.cake_outlined),
                            labelText: 'Ngày sinh',
                          ),
                        ),
                      ),
                      Icon(
                        Icons.calendar_today,
                      )
                    ],
                  ),
                ),
                TextFormField(
                  cursorColor: MaterialColors.mainColor,
                  controller: phoneController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.phone),
                    labelText: 'Số điện thoại',
                  ),
                ),
                TextFormField(
                    cursorColor: MaterialColors.mainColor,
                    controller: addressController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.home_work_outlined),
                      labelText: 'Địa chỉ',
                    )),
                TextFormField(
                    cursorColor: MaterialColors.mainColor,
                    controller: giftedController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.star_outline),
                      labelText: 'Tài năng',
                    )),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          ElevatedButton(
            child: Text('Cập nhật', style: TextStyle(color: Colors.black)),
            onPressed: () async {
              var link = "https://firebasestorage.googleapis.com/v0/b/pimo-fc268.appspot.com/o/images%2F12728867_446728072204323_8942144823096127805_n.jpg?alt=media&token=760d93c4-561e-45b7-9de6-67d5690a15bf";
              Map<String, dynamic> params = Map<String, dynamic>();
              // params['id'] = widget.modelDetail.id;
              params['name'] = nameController.text;
              // params['genderName'] = genderController;
              params['description'] = "HELLO WORLD";
              params['genderId'] = 1.toString();
              params['dateOfBirth'] = _date.toString();
              params['country'] = addressController.text;
              params['imageAvatar'] = '';
              params['province'] = "Gia Lai";
              params['district'] = "QUan 2";
              params['phone'] = phoneController.text;
              params['gifted'] = giftedController.text;
              params['facebook'] = "string";
              params['instagram'] = "string";
              params['twitter'] = "string";
              params['linkAvatar']  = link;
              var form = new FormData.fromMap(params);

              updateModelDetail(form);

              await FlutterSession().set("modelName", nameController.text);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MultiProvider(
                            providers: [
                              ChangeNotifierProvider(
                                  create: (_) => ModelViewModel()),
                            ],
                            child: FutureBuilder(
                              builder: (context, snapshot) {
                                return ModelProfilePage(
                                  modelId: widget.modelDetail.id,
                                  // oldImage: params['linkAvatar'],
                                );
                              },
                            ))),
              );
            },
            style: ElevatedButton.styleFrom(
                primary: MaterialColors.mainColor,
                elevation: 0,
                minimumSize: Size(10, 50)),
          ),
        ],
      ),
    );
  }
}
