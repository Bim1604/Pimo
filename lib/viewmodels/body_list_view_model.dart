import 'package:flutter/cupertino.dart';
import 'package:pimo/models/body.dart';
import 'package:pimo/services/body_service.dart';
import 'package:pimo/viewmodels/body_view_model.dart';

class BodyPartListViewModel with ChangeNotifier {

  List<BodyPartViewModel> listBodyPart = new List<BodyPartViewModel>();

  Future<BodyPartListViewModel> getListBodyPart() async {
    List<BodyPart> list = await BodyPartService().getBodyPartList();
    notifyListeners();
    this.listBodyPart = list.map((value)
        => BodyPartViewModel(bodyPart: value)).toList();
  }

  // Future<BodyPartListViewModel> updateAtt(List<Map<String, dynamic>> params) async {
  //   return Future.delayed(const Duration(seconds: 1), () async {
  //     await ModelAttributeService().updateAttsList(params);
  //     notifyListeners();
  //   });
  // }
}