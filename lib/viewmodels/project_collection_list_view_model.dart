import 'package:flutter/cupertino.dart';
import 'package:pimo/models/collection.dart';
import 'package:pimo/services/collection_service.dart';
import 'package:pimo/viewmodels/collection_view_model.dart';

class CollectionListViewModel with ChangeNotifier {

  List<CollectionViewModel> listCollection = new List<CollectionViewModel>();

  Future<CollectionListViewModel> getCollectionProject() async {
    List<Collection> list = await CollectionService().fetchCollectionProject();
    notifyListeners();
    this.listCollection = list.map((collections) => CollectionViewModel(collection: collections)).toList();
  }
}