
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:pimo/constants/Theme.dart';
import 'package:pimo/services/image_service.dart';
import 'package:pimo/viewmodels/model_view_model.dart';
import 'package:provider/provider.dart';

import 'model_profile.dart';

class CameraWidget extends StatefulWidget {
  final int modelId;
  const CameraWidget({Key key, this.modelId}) : super(key: key);

  @override
  State createState() {
    return CameraWidgetState();
  }
}

class CameraWidgetState extends State<CameraWidget> {
  @override
  void initState() {
    super.initState();
    // PushNotificationService().init(context);
  }

  PickedFile imageFile;

  Future _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Lựa chọn",
              style: TextStyle(color: MaterialColors.mainColor),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 2,
                    color: MaterialColors.mainColor,
                  ),
                  ListTile(
                    onTap: () {
                      _openGallery(context);
                    },
                    title: Text("Ảnh"),
                    leading: Icon(
                      Icons.image,
                      color: MaterialColors.mainColor,
                    ),
                  ),
                  Divider(
                    height: 2,
                    color: MaterialColors.mainColor,
                  ),
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                    },
                    title: Text("Camera"),
                    leading: Icon(
                      Icons.camera,
                      color: MaterialColors.mainColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thay avatar"),
        backgroundColor: MaterialColors.mainColor,
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => {_showChoiceDialog(context)},
                child: Container(
                  width: 320,
                  height: 320,
                  decoration: BoxDecoration(
                      color: MaterialColors.mainColor,
                      borderRadius: BorderRadius.all(Radius.circular(160)),
                      border: Border.all(
                        color: MaterialColors.mainColor,
                      )),
                  child: (imageFile == null)
                      ? Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Chọn ảnh",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  )
                      : Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: FileImage(File(imageFile.path)),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () async {
                  if (imageFile != null) {
                    await uploadFireBase(imageFile.path, widget.modelId);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MultiProvider(
                                  providers: [
                                    ChangeNotifierProvider(
                                        create: (_) => ModelViewModel()),
                                  ],
                                  child: FutureBuilder(
                                    builder: (context, snapshot) {
                                      return ModelProfilePage(
                                        modelId: widget.modelId,
                                      );
                                    },
                                  ))),
                    );
                  } else {
                    Fluttertoast.showToast(msg: 'Vui lòng chọn ảnh');
                  }
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => MainScreen(),
                  //     ));
                },
                color: MaterialColors.mainColor,
                child: Text(
                  "Cập nhật",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile = pickedFile;
    });

    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = pickedFile;
    });
    Navigator.pop(context);
  }
}