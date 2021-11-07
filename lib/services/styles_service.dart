import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pimo/constants/Images.dart';
import 'package:pimo/models/styles.dart';

class StylesService {
  List<Styles> parseStylesList(String responseBody) {
    int count = 0;
    var list = jsonDecode(responseBody);
    List<Styles> stylesListProject = new List<Styles>();
    list['styleList'].map((e) => count++).toList();
    for (int i = 0; i < count; i++) {
      stylesListProject.add(Styles.fromJson(list['styleList'][i]));
    }
    return stylesListProject;
  }

  Future<List<Styles>> getStylesList() async {
    // var token = (await FlutterSession().get("token")).toString();
    // Map<String, String> heads = Map<String, String>();
    // heads['Content-Type'] = 'application/json';
    // heads['Accept'] = 'application/json';
    // heads['Authorization'] = 'Bearer $token';
    // String modelId = (await FlutterSession().get('modelId')).toString();
    final response = await http.get(Uri.parse(url + "api/v1/models/1"));
    if (response.statusCode == 200) {
      var list = parseStylesList(response.body);
      return list;
    } else {
      throw Exception("Cannot fetch body ");
    }
  }
}
