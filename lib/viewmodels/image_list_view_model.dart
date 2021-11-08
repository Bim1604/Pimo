

import 'package:flutter/cupertino.dart';
import 'package:pimo/models/image.dart';
import 'package:pimo/services/image_service.dart';

import 'model_image_view_model.dart';

class ImageListViewModel with ChangeNotifier {
  List<ModelImageViewModel> images = List<ModelImageViewModel>();

  Future<ImageListViewModel> getImageList(int collectionId, int index, String modelId) async {
    List<ModelImage> list = await ImageService().getImageList(collectionId, index, modelId);
    notifyListeners();
    this.images =
        list.map((images) => ModelImageViewModel(image: images)).toList();
  }
}