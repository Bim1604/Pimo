import 'package:flutter/cupertino.dart';
import 'package:pimo/models/body_attribute.dart';
import 'package:pimo/services/body_attribute_service.dart';

import 'body_attribute_view_model.dart';

class BodyAttributeListViewModel with ChangeNotifier {
  List<ModelAttributeViewModel> atts = List<ModelAttributeViewModel>();

  Future<BodyAttributeListViewModel> getAttList(int bodyPartId) async {
    return Future.delayed(const Duration(seconds: 1), () async {
      List<BodyAttribute> list = await ModelAttributeService().getAttsList(bodyPartId);
      notifyListeners();
      this.atts = list.map((att) => ModelAttributeViewModel(bodyAttribute: att)).toList();
    });
  }

  Future<BodyAttributeListViewModel> updateAtt(List<Map<String, dynamic>> params) async {
    return Future.delayed(const Duration(seconds: 1), () async {
      await ModelAttributeService().updateAttsList(params);
      notifyListeners();
    });
  }
}