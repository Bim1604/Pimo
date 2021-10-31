
import 'dart:convert';
import 'package:pimo/constants/Images.dart';
import 'package:pimo/models/casting.dart';
import 'package:http/http.dart' as http;
import 'package:pimo/viewmodels/casting_view_model.dart';
class CastingService {
  List<Casting> parseCastingList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Casting>((json) => Casting.fromJson(json)).toList();
  }

  Future<List<Casting>> getCastingList() async {
    // var token = (await FlutterSession().get("token")).toString();
    // Map<String, String> heads = Map<String, String>();
    // heads['Content-Type'] = 'application/json';
    // heads['Accept'] = 'application/json';
    // heads['Authorization'] = 'Bearer $token';
    // var modelId = (await FlutterSession().get("modelId")).toString();
    // final response =
    // await http.get(Uri.parse(url + "api/v1/castings"), headers: heads);
    final response =
    await http.get(Uri.parse(url + "api/v1/castings"));
    if (response.statusCode == 200) {
      var list = parseCastingList(response.body);
      return list;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<Casting>> searchCastingList(
      String name, String min, String max) async {
    // var token = (await FlutterSession().get("token")).toString();
    // Map<String, String> heads = Map<String, String>();
    // heads['Content-Type'] = 'application/json';
    // heads['Accept'] = 'application/json';
    // heads['Authorization'] = 'Bearer $token';
    // final response = await http.get(
    //     Uri.parse(
    //         url + "api/v1/castings/search?name=$name&min=$min&max=$max"),
    //     headers: heads);
    final response = await http.get(
        Uri.parse(
            url + "api/v1/castings/search?name=$name&min=$min&max=$max"));
    if (response.statusCode == 200) {
      var list = parseCastingList(response.body);
      return list;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<Casting>> modelApplyCasting() async {
    // var modelId = (await FlutterSession().get("modelId")).toString();
    // var token = (await FlutterSession().get("token")).toString();
    // Map<String, String> heads = Map<String, String>();
    // heads['Content-Type'] = 'application/json';
    // heads['Accept'] = 'application/json';
    // heads['Authorization'] = 'Bearer $token';
    final response = await http.get(
        Uri.parse(url + 'api/v1/castings/1/apply'));
    if (response.statusCode == 200) {
      var list = parseCastingList(response.body);
      return list;
    } else {
      // return null;
      throw Exception('Failed to load');
    }
  }

  Future<List<Casting>> getIncomingCasting() async {
    // var modelId = (await FlutterSession().get("modelId")).toString();
    // var token = (await FlutterSession().get("token")).toString();
    // Map<String, String> heads = Map<String, String>();
    // heads['Content-Type'] = 'application/json';
    // heads['Accept'] = 'application/json';
    // heads['Authorization'] = 'Bearer $token';
    // final response = await http.get(
    //     Uri.parse(url + 'api/v1/castings/$modelId/incoming'),
    //     headers: heads);
    final response = await http.get(
          Uri.parse(url + 'api/v1/castings/1/incoming'));
    if (response.statusCode == 200) {
      var list = parseCastingList(response.body);
      return list;
    } else {
      return null;
      // throw Exception('Failed to load');
    }
  }

  Future<CastingViewModel> getCasting(String castingId) async {
    // var modelId = (await FlutterSession().get("modelId")).toString();
    // var token = (await FlutterSession().get("token")).toString();
    // Map<String, String> heads = Map<String, String>();
    // heads['Content-Type'] = 'application/json';
    // heads['Accept'] = 'application/json';
    // heads['Authorization'] = 'Bearer $token';

    // final response = await http
    //     .get(Uri.parse(url + 'api/v1/castings/$castingId'), headers: heads);
    final response = await http
        .get(Uri.parse(url + 'api/v1/castings/$castingId'));
    if (response.statusCode == 200) {
      var casting = CastingViewModel(
          casting: Casting.fromJson(jsonDecode(response.body)));
      return casting;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<Casting>> getCastingByIds(List<int> castingIds) async {
    Map<String, dynamic> params = Map<String, dynamic>();
    params['castingIds'] = castingIds;

    // var token = (await FlutterSession().get("token")).toString();
    // Map<String, String> heads = Map<String, String>();
    // heads['Content-Type'] = 'application/json';
    // heads['Accept'] = 'application/json';
    // heads['Authorization'] = 'Bearer $token';

    final message = jsonEncode(params);
    final response = await http.post(Uri.parse(url + 'api/v1/castings'),
        body: message);
    if (response.statusCode == 200) {
      var list = parseCastingList(response.body);
      return list;
    } else {
      throw Exception('Failed to load');
    }
  }

// Future startThread() async {
//   var modelId = (await FlutterSession().get("modelId")).toString();

//   final response =
//       await http.get(Uri.parse(url + 'api/v1/castings/$modelId/thread'));
//   if (response.statusCode == 200) {
//     // var casting = CastingViewModel(
//     //     casting: Casting.fromJson(jsonDecode(response.body)));
//     // return casting;
//   } else {
//     Fluttertoast.showToast(msg: 'Not found');
//     throw Exception('Failed to load');
//   }
// }

// Future endThread() async {
//   final response =
//       await http.get(Uri.parse(url + 'api/v1/castings/end-thread'));
//   if (response.statusCode == 200) {
//     // var casting = CastingViewModel(
//     //     casting: Casting.fromJson(jsonDecode(response.body)));
//     // return casting;
//   } else {
//     Fluttertoast.showToast(msg: 'Not found');
//     throw Exception('Failed to load');
//   }
// }
}