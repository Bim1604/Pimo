
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pimo/constants/Theme.dart';
import 'package:pimo/viewmodels/model_view_model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'model_profile.dart';

class UpdateModelProfilePage extends StatefulWidget {
  final String modelId;
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
          // actions: [
          //   IconButton(
          //       icon: Icon(CupertinoIcons.moon_stars, color: Color(0xFFF54E5E),),
          //       onPressed: () => {}
          //   )
          // ],
        ),
        body: Center(
          child: FutureBuilder<ModelViewModel>(
            future: Provider.of<ModelViewModel>(context, listen: false)
                .getModel(),
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
                  return Consumer<ModelViewModel>(
                      builder: (ctx, data, child) => ModelUpdate(
                            modelDetail: data,
                          ));
                  return ModelUpdate(
                      modelDetail:
                          Provider.of<ModelViewModel>(context, listen: false));
                } else {
                  return Text('Error');
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
  int genderController;
  TextEditingController nameController,
      dobController,
      phoneController,
      addressController,
      giftedController;

  GlobalKey<FormState> _profileKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    dobController.dispose();
    phoneController.dispose();
    addressController.dispose();
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
    // genderController = widget.modelDetail.gender;
    dobController = TextEditingController()
      ..text = formatDate(widget.modelDetail.dateOfBirth);
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
                    suffixIcon: Icon(
                      Icons.check_circle,
                    ),
                  ),
                ),
                DropdownButtonFormField(
                  value: genderController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.drive_file_rename_outline),
                    labelText: 'Gender',
                    // suffixIcon: Icon(
                    //   Icons.check_circle,
                    // ),
                  ),
                  items: [
                    DropdownMenuItem(
                      child: Text("Male"),
                      value: 0,
                    ),
                    DropdownMenuItem(
                      child: Text("Female"),
                      value: 1,
                    )
                  ],
                  onChanged: (int value) {
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
                            labelText: 'Date of birth',
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
                    labelText: 'Phone number',
                  ),
                ),
                TextFormField(
                    cursorColor: MaterialColors.mainColor,
                    controller: addressController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.home_work_outlined),
                      labelText: 'Address',
                    )),
                TextFormField(
                    cursorColor: MaterialColors.mainColor,
                    controller: giftedController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.star_outline),
                      labelText: 'Gifted',
                    )),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          ElevatedButton(
            child: Text('UPDATE', style: TextStyle(color: Colors.black)),
            onPressed: () async {
              Map<String, dynamic> params = Map<String, dynamic>();
              params['id'] = widget.modelDetail.id;
              params['name'] = nameController.text;
              params['gender'] = genderController;
              params['dateOfBirth'] = _date.toString();
              params['country'] = addressController.text;
              params['phone'] = phoneController.text;
              params['gifted'] = giftedController.text;
              await Provider.of<ModelViewModel>(context, listen: false)
                  .updateProfileModel(params);
              // await FlutterSession().set("modelName", nameController.text);
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
                                  // modelId: widget.modelDetail.id,
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
