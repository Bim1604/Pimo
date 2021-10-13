import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pimo/models/casting.dart';

class NetworkRequest {
  static var url = Uri.https('api.pimo.studio','/api/v1/castings/information/1');

  static List<Casting> parseCasting (String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<Casting> casting = list.map((e) => Casting.fromJson(e)).toList();
    return casting;
  }

  static Future<List<Casting>> fetchCasting() async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return compute(parseCasting, response.body);
    } else {
      throw Exception('Can\'t get post');
    }
  }
}