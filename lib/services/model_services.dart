import 'dart:convert';

import 'package:pimo/constants/Images.dart';
import 'package:pimo/models/model.dart';
import 'package:http/http.dart' as http;
class ModelServices {

  Future<Model> updateModelDetail(Map<String, dynamic> params) async {
    final message = jsonEncode(params);
    final response = await http.put(
        Uri.parse(
            url + 'api/v1/models/${params["id"]}'),
        body: message,
        );
    if (response.statusCode == 200) {
      var responseBody = Model.fromJson(jsonDecode(response.body));
      return responseBody;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<Model> getModelDetail() async {
    final response = await http
        .get(Uri.parse('https://api.pimo.studio/api/v1/models/1'));
    if (response.statusCode == 200) {
      var model = Model.fromJson(jsonDecode(response.body));
      return model;
    } else {
      throw Exception('Failed to load Model !');
    }
  }
}
