import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pimo/constants/Images.dart';
import 'package:pimo/models/body_attribute.dart';

class ModelAttributeService {

  List<BodyAttribute> parseAttsList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<BodyAttribute>((json) => BodyAttribute.fromJson(json)).toList();
  }

  Future<List<BodyAttribute>> getAttsList(int bodyPartId) async {
    // var token = (await FlutterSession().get("token")).toString();
    // Map<String, String> heads = Map<String, String>();
    // heads['Content-Type'] = 'application/json';
    // heads['Accept'] = 'application/json';
    // heads['Authorization'] = 'Bearer $token';
    final response = await http
        .get(Uri.parse(url + "api/v1/body-attributes/" + bodyPartId.toString()));
    if (response.statusCode == 200) {
      var list = parseAttsList(response.body);
      return list;
    } else {
      throw Exception('Failed to load');
    }
  }


  Future updateAttsList(List<Map<String, dynamic>> params) async {
    // var token = (await FlutterSession().get("token")).toString();
    // Map<String, String> heads = Map<String, String>();
    // heads['Content-Type'] = 'application/json';
    // heads['Accept'] = 'application/json';
    // heads['Authorization'] = 'Bearer $token';
    final message = jsonEncode(params);
    final response = await http
        .put(Uri.parse(url + "api/v1/body-attributes/update"),
        body: message,
        );
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to load');
    }
  }
}