
import 'package:flutter/material.dart';
import 'package:pimo/models/body_part.dart';

import 'body_part_view_model.dart';

class BodyPartListViewModel with ChangeNotifier {
  List<BodyPartViewModel> bodyParts = List<BodyPartViewModel>();

  Future<BodyPartListViewModel> getBodyPartList() async {
    List<BodyPart> list = await BodyPartService().getBodyPartList();
    notifyListeners();
    this.bodyParts =
        list.map((collections) => BodyPartViewModel(bodyPart: collections)).toList();
  }
}
