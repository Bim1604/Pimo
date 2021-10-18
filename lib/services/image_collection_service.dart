import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:pimo/constants/Images.dart';
import 'package:pimo/models/image_collection.dart';
import 'package:http/http.dart' as http;
import 'package:pimo/models/image_collection_gif.dart';

import 'image_service.dart';

class ImageCollectionService {
  // List<ImageCollection> parseImageCollectionList(String responseBody) {
  //   print("ImageCollection Service: parseImageCollectionList");
  //   print(responseBody);
  //   final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  //   print(parsed.toString());
  //   return parsed.map<ImageCollection>((json) => ImageCollection.fromJson(json)).toList();
  // }

  // Future<List<ImageCollection>> getImageCollectionList() async {
  //   //Map<String, String> heads = Map<String, String>();
  //   final response = await http.get(Uri.parse("https://api.pimo.studio/api/v1/models/1"));
  //   print("Chay dau cho thoat ImageCollection");
  //   if (response.statusCode == 200) {
  //     print("image_collection_service: getImageCollectionList");
  //     var list = parseImageCollectionList(response.body);
  //     return list;
  //   } else {
  //     print('Em da sai');
  //     return null;
  //   }
  // }

  Future<ImageCollection> getImageCollectionList() async {
    //Map<String, String> heads = Map<String, String>();
    final response = await http.get(Uri.parse("https://api.pimo.studio/api/v1/models/1"));
    print("Chay dau cho thoat ImageCollection");
    if (response.statusCode == 200) {
      print("image_collection_service: getImageCollectionList");
      var list = ImageCollection.fromJson(jsonDecode(response.body));
      return list;
    } else {
      print('Em da sai');
      return null;
    }
  }

  Future<ImageCollection> getImageCollectionDetail() async {
    final response = await http
        .get(Uri.parse('https://api.pimo.studio/api/v1/models/1'));
    if (response.statusCode == 200) {
      var image = ImageCollection.fromJson(jsonDecode(response.body));
      print("ImageCollectionService: Insert success");
      return image;
    } else {
      throw Exception('Failed to load ImageCollection !');
    }
  }




  Future<void> createCollection(String collectionName) async {
    // var token = (await FlutterSession().get("token")).toString();
    Map<String, String> heads = Map<String, String>();
    heads['Content-Type'] = 'application/json';
    heads['Accept'] = 'application/json';
    // heads['Authorization'] = 'Bearer $token';
    Map<String, dynamic> body = Map<String, dynamic>();
    body['name'] = collectionName;
    var mess = jsonEncode(body);

    // String modelId = (await FlutterSession().get('modelId')).toString();
// final response = await http
    //     .post(Uri.parse(url + "api/v1/collection-images/$modelId"),
    //     body: mess,
    //     headers: heads);
    final response = await http.get(Uri.parse(url + "api/v1/models/1"));

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Create success');
    } else {
      Fluttertoast.showToast(msg: 'Create fail');
      return null;
    }
  }

  Future<void> deleteCollection(int collectionId) async {
    // var token = (await FlutterSession().get("token")).toString();
    Map<String, String> heads = Map<String, String>();
    heads['Content-Type'] = 'application/json';
    heads['Accept'] = 'application/json';
    // heads['Authorization'] = 'Bearer $token';
    final response = await http.delete(
        Uri.parse(url + "api/v1/collection-images/$collectionId"),
        headers: heads);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Delete success');
    } else {
      Fluttertoast.showToast(msg: 'Delete fail');
      return null;
    }
  }

/*
Future<bool> convertToGif(int collectionId) async {
  var images = await ImageService().getImageList(collectionId);

  List<Map<String, dynamic>> fileValues = List<Map<String, dynamic>>();
  for (int i = 0; i < images.length; i++) {
    Map<String, dynamic> url = Map<String, dynamic>();
    url['Url'] = images.elementAt(i).fileName;
    fileValues.add(url);
  }
  // Map<String, dynamic> urlsEx = Map<String, dynamic>();
  // urlsEx['Name'] = 'F:\\my_file.jpg';
  // urlsEx['Data'] = 'Base64';
  // fileValues.add(urlsEx);

  List<Map<String, dynamic>> parameters = List<Map<String, dynamic>>();
  Map<String, dynamic> files = Map<String, dynamic>();
  files['Name'] = 'Files';
  files['FileValues'] = fileValues;
  parameters.add(files);

  Map<String, dynamic> storeFiles = Map<String, dynamic>();
  storeFiles['Name'] = 'StoreFile';
  storeFiles['Value'] = true;
  parameters.add(storeFiles);

  Map<String, dynamic> parameter = Map<String, dynamic>();
  parameter['Parameters'] = parameters;

  final message = jsonEncode(parameter);

  final response = await http.post(
      Uri.parse(
          'https://v2.convertapi.com/convert/jpg/to/gif?Secret=afGAodLwkQyIPtOQ'),
      body: message,
      headers: {"Content-Type": "application/json"});
  if (response.statusCode == 200) {
    var json = jsonDecode(response.body);
    var gif = ImageCollectionGif.fromJson(json);
    await ImageService().saveGif(gif, collectionId);
    return true;
  } else {
    Fluttertoast.showToast(msg: 'Picture must same size');
    return false;
  }
}
*/
}


