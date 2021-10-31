import 'package:flutter/material.dart';
import 'package:pimo/constants/Theme.dart';
import 'package:pimo/services/collection_service.dart';
import 'package:pimo/services/image_collection_service.dart';
import 'package:pimo/services/image_service.dart';
import 'package:pimo/viewmodels/collection_project_list_view_model.dart';
import 'package:pimo/viewmodels/collection_project_view_model.dart';
import 'package:pimo/viewmodels/image_collection_view_model.dart';
import 'package:pimo/viewmodels/image_list_view_model.dart';
import 'package:pimo/viewmodels/model_image_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'intro_image.dart';


class ImageInCollectionPage extends StatefulWidget {
  // final ImageCollectionViewModel collection;
  final CollectionProjectViewModel collection;
  final int index;
  const ImageInCollectionPage({Key key, this.collection, this.index})
      : super(key: key);

  @override
  _ImageInCollectionPageState createState() => _ImageInCollectionPageState();
}

class _ImageInCollectionPageState extends State<ImageInCollectionPage> {
  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Chi tiết"),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: (widget.collection == null)
                  ? !isLoading
                  ? GestureDetector(
                child: Icon(
                  Icons.gif,
                  size: 40,
                ),
                onTap: () async {
                  setState(() {
                    isLoading = true;
                  });
                  // var check = await ImageCollectionService()
                  //     .convertToGif(widget.collection.id);
                  setState(() {
                    isLoading = false;
                  });
                  // if (check) {
                  //  Body of image
                  // }

                  var collection = CollectionProjectViewModel(
                      listCollectionProject:
                      (await ImageCollectionService()
                          .getImageInCollectionList(widget.collection.idCollection))
                          .elementAt(widget.index));
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MultiProvider(
                            providers: [
                              ChangeNotifierProvider(
                                  create: (_) =>
                                      ImageListViewModel()
                                  // create: (_) =>
                                  //     ListCollectionProjectListViewModel()
                              ),
                            ],
                            child: FutureBuilder(
                              builder: (context, snapshot) {
                                print('Xem gi hay ne: ImageIncollection');
                                return ImageInCollectionPage(
                                  collection: collection,
                                );
                              },
                            ))),
                  );
                },
              )
                  : Center(child: CircularProgressIndicator(
                color: Colors.black,
              ))
                  : null,
            ),
          ],
          backgroundColor: MaterialColors.mainColor,
        ),
        floatingActionButton: (widget.collection == null)
            ? FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.black,
          onPressed: () async => {
            // await ImageService().uploadImage(widget.collection.id),
            // _reloadPage()
          },
        )
            : null,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              (widget.collection == null)
                  ? Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    'Ảnh',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
                  : Padding(padding: EdgeInsets.zero),
              Expanded(
                child:  FutureBuilder<ImageListViewModel>(
                      future: Provider.of<ImageListViewModel>(context,
                          listen: false)
                          .getImageList(widget.collection.idCollection),
                      builder: (context, data) {
                        if (data.connectionState ==
                            ConnectionState.waiting) {
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
                            print('Chayj den day r');
                            return Consumer<ImageListViewModel>(
                              builder: (ctx, data, child) =>
                                  StaggeredGridView.countBuilder(
                                      crossAxisCount: 2,
                                      itemCount: data.images.length,
                                      itemBuilder: (context, index) {
                                        return _buildImageList((context),
                                            data.images[index], index);
                                      },
                                      staggeredTileBuilder: (index) {
                                        return new StaggeredTile.count(
                                            1, index.isEven ? 1.2 : 2);
                                      }),
                            );
                          } else {
                            return Center(child: Text('Không có hình ảnh'),);
                          }
                        }
                      },
                    )
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageList(
      BuildContext context, ModelImageViewModel image, int index) {
    bool isSelect = false;
    Future _showDialog(BuildContext context) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                "Bạn chắc chắn muốn xóa?",
                style: TextStyle(color: MaterialColors.mainColor),
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
                    // await ImageService().deleteImage(image.fileName, image.id);
                    // Navigator.of(context).pop();
                    // _reloadPage();
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

    return GestureDetector(
        onLongPress: () => {
          _showDialog(context),
        },
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MultiProvider(
                    providers: [
                      ChangeNotifierProvider(
                          create: (_) => ListCollectionProjectListViewModel()),
                    ],
                    child: FutureBuilder(
                      builder: (context, snapshot) {
                        return IntroImagePage(
                          beginIndex: index,
                          collectionId: widget.collection.idCollection,
                        );
                      },
                    ))),
          );
        },
        child: (!isSelect)
            ? Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: Offset(-2, 5),
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.3),
                )
              ],
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(
                    image.fileName,
                  ),
                  fit: BoxFit.cover)
          ),
        )
            : Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: Offset(-2, 5),
                blurRadius: 10,
                color: MaterialColors.mainColor.withOpacity(0.3),
              )
            ],
            color: MaterialColors.mainColor,
            borderRadius: BorderRadius.circular(10),
          ),
        ));
  }

  Future _reloadPage() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => ListCollectionProjectListViewModel()),
              ],
              child: FutureBuilder(
                builder: (context, snapshot) {
                  return ImageInCollectionPage(
                    collection: widget.collection,
                  );
                },
              ))),
    );
  }
}