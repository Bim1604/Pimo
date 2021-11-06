import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:pimo/constants/Images.dart';
import 'package:pimo/models/model.dart';
import 'package:http/http.dart' as http;
import 'package:pimo/module/deprecated/flutter_session/flutter_session.dart';

class ModelServices {
  Future<Model> updateModelDetail(Map<String, dynamic> params) async {
    final message = jsonEncode(params);

    var jwt = (await FlutterSession().get("jwt")).toString();
    print("RESPONSE: " + params.toString());
    Map<String, String> heads = Map<String, String>();
    heads['Content-Type'] = "multipart/form-data; boundary=AaB03x" +
        "--AaB03x" +
        "Content-Disposition: file" +
        "Content-Type: png" +
        "Content-Transfer-Encoding: binary" +
        "...data... " +
        "--AaB03x--";
    heads['Accept'] = 'application/json';
    heads['type'] = "formData";
    heads['Authorization'] = 'Bearer $jwt';
    final response = await http.put(
      Uri.parse(url + 'api/v1/models'),
      body: message,
      headers: {
        "Content-Type": "multipart/form-data",
        "Accept": "application/json",
        "Authorization": 'Bearer $jwt',
        }
    );
    try {
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Cập nhật thành công');
      } else {
        print(response.headers);
      }
    } on Exception catch (exception) {
      print("Exception: "+ exception.toString());
    } catch (error) {
      print("ERROR: " + error.toString());
    };

  }

  Future<Model> getModelDetail(int modelId) async {
    print("MODEL DETAILS");
    print(modelId);
    final response =
        await http.get(Uri.parse('https://api.pimo.studio/api/v1/models/$modelId'));
    if (response.statusCode == 200) {
      var model = Model.fromJson(jsonDecode(response.body));
      return model;
    } else {
      throw Exception('Failed to load Model !');
    }
  }
}
