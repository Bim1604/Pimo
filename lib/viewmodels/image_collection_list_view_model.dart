import 'package:flutter/cupertino.dart';
import 'package:pimo/models/image_collection.dart';
import 'package:pimo/services/image_collection_service.dart';
import 'image_collection_view_model.dart';


class ImageCollectionListViewModel with ChangeNotifier {
  List<ImageCollectionViewModel> imageCollections = List<ImageCollectionViewModel>();

  Future<ImageCollectionListViewModel> getImageCollectionList() async {
    print("Future Image Collection List View");
    List<ImageCollection> list = await ImageCollectionService().getImageCollectionList();
    notifyListeners();
    this.imageCollections =
        list.map((collections) => ImageCollectionViewModel(imageCollection: collections)).toList();
  }
}