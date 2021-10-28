import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pimo/constants/Theme.dart';
import 'package:pimo/services/image_collection_service.dart';
import 'package:pimo/viewmodels/image_collection_list_view_model.dart';
import 'package:pimo/viewmodels/image_collection_view_model.dart';
import 'package:pimo/viewmodels/image_list_view_model.dart';
import 'package:provider/provider.dart';

import 'image_in_collection.dart';

class ModelCollection extends StatefulWidget {
  final String modelId;
  const ModelCollection({Key key, this.modelId}) : super(key: key);

  @override
  _ModelImagePageState createState() => _ModelImagePageState();
}

class _ModelImagePageState extends State<ModelCollection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.black,
          onPressed: () async => {await _showDialog(context, widget.modelId)},
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    'Hình ảnh',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: FutureBuilder<ImageCollectionListViewModel>(
                      future: Provider.of<ImageCollectionListViewModel>(context,
                          listen: false)
                          .getImageCollectionList(),
                      builder: (context, data) {
                        if (data.connectionState == ConnectionState.waiting) {
                          return Column(
                            children: <Widget>[
                              SizedBox(
                                height: 150,
                              ),
                              Center(child: CircularProgressIndicator()),
                            ],
                          );
                        } else {
                          if (data.error == null) {
                            return Consumer<ImageCollectionListViewModel>(
                              builder: (ctx, data, child) => ListView.builder(
                                itemCount: 2,
                                itemBuilder: (BuildContext context, int index) {
                                  // print(context);
                                  print(index);
                                  // print(data.imageCollections[index]);
                                  return _buildImageCollectList((context),
                                      data.imageCollections[index], index);
                                },
                              ),
                            );
                          } else {
                            return Center(
                              child: Text('Hiện tại chưa có bộ sưu tập'),
                            );
                          }
                        }
                      },
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageCollectList(
      BuildContext context, ImageCollectionViewModel collection, int index) {
    // Size size = MediaQuery.of(context).size;
    Future _showDeleteDialog(BuildContext context, int id) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                "Bạn muốn xóa?",
                style: TextStyle(color: Colors.black),
              ),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Hủy',
                    style: TextStyle(color: Colors.grey),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    elevation: 0,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // await ImageCollectionService().deleteCollection(id);
                    // Navigator.of(context).pop();
                    // await _reloadPage();
                  },
                  child: const Text(
                    'Xóa',
                    style: TextStyle(color: MaterialColors.mainColor),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    elevation: 0,
                  ),
                ),
              ],
            );
          });
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(-2, 5),
              blurRadius: 10,
              color: MaterialColors.mainColor.withOpacity(0.5),
            )
          ],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: MaterialColors.mainColor,
          ),
        ),
        child: FlatButton(
          padding: EdgeInsets.only(left: 30, top: 15, bottom: 15),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.white,
          onLongPress: () async {
            await _showDeleteDialog(context, collection.id);
          },
          onPressed: () {
            (index == 0
                ? (Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(
                            create: (_) => ImageListViewModel()),
                      ],
                      child: FutureBuilder(
                        builder: (context, snapshot) {
                          return ImageInCollectionPage(
                            collection: collection,
                            index: index,
                          );
                        },
                      ))),
            ))
                : null);
          },
          child: Row(
            children: [
              Expanded(
                child: Text(
                  (index == 0 ? 'Bộ sưu tập dự án' : 'Bộ sưu tập cơ thể'),
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Icon(
                Icons.navigate_next,
              ),
              SizedBox(
                width: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _reloadPage() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider(
                    create: (_) => ImageCollectionListViewModel()),
              ],
              child: FutureBuilder(
                builder: (context, snapshot) {
                  return ModelCollection(
                    modelId: widget.modelId,
                  );
                },
              ))),
    );
  }

  void _showDialog(BuildContext context, String modelId) async {
    TextEditingController nameController;
    nameController = TextEditingController()..text = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Tạo bộ sưu tập"),
          content: Builder(
            builder: (context) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 50,
                width: 350,
                child: ListView(
                  children: [
                    TextFormField(
                      cursorColor: MaterialColors.mainColor,
                      controller: nameController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.drive_file_rename_outline),
                        labelText: 'Tên',
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
                'Hủy',
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
                'Tạo',
                style: TextStyle(color: MaterialColors.mainColor),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                elevation: 0,
              ),
              onPressed: () async {
                if (nameController.text.isNotEmpty) {
                  await ImageCollectionService()
                      .createCollection(nameController.text);
                  Navigator.of(context).pop();
                  await _reloadPage();
                } else {
                  Fluttertoast.showToast(msg: 'Tên không được để trống');
                }
              },
            ),
          ],
        );
      },
    );
  }
}