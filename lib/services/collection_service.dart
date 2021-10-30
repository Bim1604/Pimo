

import 'dart:convert';

import 'package:pimo/constants/Images.dart';
import 'package:http/http.dart' as http;
import 'package:pimo/models/collection_project.dart';
class CollectionService {
  List<ListCollectionProject> parseImageCollectionList(String responseBody) {
    int count = 0;
    var list = jsonDecode(responseBody);
    print(list);
    List<ListCollectionProject> collectionListProject = new List<ListCollectionProject>();
    print('Đang ở giá trị parsing nè');
    list['listCollectionProject'].map((e) => count++).toList();
    for (int i = 0; i < count; i++) {
      print(list['listCollectionProject'][i]);
      collectionListProject.add(ListCollectionProject.fromJson(list['listCollectionProject'][i]));
    }
    return collectionListProject;
  }

  Future<List<ListCollectionProject>> fetchListCollectionProject() async {
    final response = await http.get(Uri.parse(url + "api/v1/models/1"));
    print(response.body);
    if (response.statusCode == 200) {
      var list = parseImageCollectionList(response.body);
      print('HIhi xong r ne');
      return list;
    } else {
      throw Exception("Request API error");
    }
  }

  // List<Collection> parseCollectionBodyList(String responseBody) {
  //   int count = 0;
  //   var list = jsonDecode(responseBody);
  //   List<Collection> collection = new List<Collection>();
  //   list['listCollectionBody'].map((e) => count++).toList();
  //   for (int i = 0; i < count; i++) {
  //     collection.add(Collection.fromJson(list['listCollectionBody'][i]));
  //   }
  //   return collection;
  // }
  //
  // Future<List<Collection>> fetchCollectionBody() async {
  //   final response = await http.get(Uri.parse(url + "api/v1/models/1"));
  //   if (response.statusCode == 200) {
  //     var list = parseCollectionBodyList(response.body);
  //     return list;
  //   } else {
  //     throw Exception("Request API error");
  //   }
  // }
  //
  // List<Collection> parseCollectionProjectList(String responseBody) {
  //   int count = 0;
  //   var list = jsonDecode(responseBody);
  //   List<Collection> collection = new List<Collection>();
  //   list['listCollectionProject'].map((e) => count++).toList();
  //   for (int i = 0; i < count; i++) {
  //     print(i);
  //     collection.add(Collection.fromJson(list['listCollectionProject'][i]));
  //   }
  //   return collection;
  // }
  //
  // Future<List<Collection>> fetchCollectionProject() async {
  //   final response = await http.get(Uri.parse(url + "api/v1/models/1"));
  //   if (response.statusCode == 200) {
  //     var list = parseCollectionProjectList(response.body);
  //     return list;
  //   } else {
  //     throw Exception("Request API error");
  //   }
  // }

}