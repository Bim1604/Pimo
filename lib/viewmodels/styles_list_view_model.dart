import 'package:flutter/cupertino.dart';
import 'package:pimo/models/styles.dart';
import 'package:pimo/services/styles_service.dart';
import 'package:pimo/viewmodels/styles_view_model.dart';

class StylesListViewModel with ChangeNotifier {
  List<StylesViewModel> listStyles = new List<StylesViewModel>();

  Future<StylesListViewModel> getListStyles() async {
    List<Styles> list = await StylesService().getStylesList();
    notifyListeners();
    this.listStyles =
        list.map((value) => StylesViewModel(styles: value)).toList();
  }
}
