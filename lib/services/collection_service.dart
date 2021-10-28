

import 'dart:convert';

import 'package:pimo/constants/Images.dart';
import 'package:pimo/models/collection.dart';
import 'package:http/http.dart' as http;
class CollectionService {

  List<Collection> parseCollectionBodyList(String responseBody) {
    int count = 0;
    var list = jsonDecode(responseBody);
    List<Collection> collection = new List<Collection>();
    list['listCollectionBody'].map((e) => count++).toList();
    for (int i = 0; i < count; i++) {
      collection.add(Collection.fromJson(list['listCollectionBody'][i]));
    }
    return collection;
  }

  Future<List<Collection>> fetchCollectionBody() async {
    final response = await http.get(Uri.parse(url + "api/v1/models/1"));
    if (response.statusCode == 200) {
      var list = parseCollectionBodyList(response.body);
      return list;
    } else {
      throw Exception("Request API error");
    }
  }

  List<Collection> parseCollectionProjectList(String responseBody) {
    int count = 0;
    var list = jsonDecode(responseBody);
    List<Collection> collection = new List<Collection>();
    list['listCollectionProject'].map((e) => count++).toList();
    for (int i = 0; i < count; i++) {
      collection.add(Collection.fromJson(list['listCollectionProject'][i]));
    }
    return collection;
  }

  Future<List<Collection>> fetchCollectionProject() async {
    final response = await http.get(Uri.parse(url + "api/v1/models/1"));
    if (response.statusCode == 200) {
      var list = parseCollectionProjectList(response.body);
      return list;
    } else {
      throw Exception("Request API error");
    }
  }

}