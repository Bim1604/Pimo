
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pimo/constants/Images.dart';
import 'package:pimo/models/casting.dart';
import 'package:http/http.dart' as http;
import 'casting_service.dart';

class ApplyCastingService {
  Future<List<Casting>> createApplyCasting(int castingId) async {
    // var modelId = (await FlutterSession().get("modelId")).toString();
    //
    // var token = (await FlutterSession().get("token")).toString();
    // Map<String, String> heads = Map<String, String>();
    // heads['Content-Type'] = 'application/json';
    // heads['Accept'] = 'application/json';
    // heads['Authorization'] = 'Bearer $token';

    Map<String, dynamic> params = Map<String, dynamic>();
    // params['modelId'] = modelId;
    params['castingId'] = castingId;

    final message = jsonEncode(params);
    final response = await http.post(
        Uri.parse(url + 'api/v1/apply-castings'),
        body: message);
        // headers: heads);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Apply success');
      return await CastingService().modelApplyCasting();
    } else {
      throw Exception('Failed to load');
    }
  }

  // Future<List<Casting>> deleteApplyCasting(int castingId) async {
  //   var modelId = (await FlutterSession().get("modelId")).toString();
  //   var token = (await FlutterSession().get("token")).toString();
  //   Map<String, String> heads = Map<String, String>();
  //   heads['Content-Type'] = 'application/json';
  //   heads['Accept'] = 'application/json';
  //   heads['Authorization'] = 'Bearer $token';
  //   final response = await http.delete(
  //       Uri.parse(url +
  //           'api/v1/apply-castings/cancel?modelId=$modelId&castingId=$castingId'),
  //       headers: heads);
  //   if (response.statusCode == 200) {
  //     Fluttertoast.showToast(msg: 'Cancel success');
  //     return await CastingService().modelApplyCasting();
  //   } else {
  //     throw Exception('Failed to load');
  //   }
  // }

  Future<bool> isApply(int castingId) async {
    // var modelId = (await FlutterSession().get("modelId")).toString();
    // var token = (await FlutterSession().get("token")).toString();
    // Map<String, String> heads = Map<String, String>();
    // heads['Content-Type'] = 'application/json';
    // heads['Accept'] = 'application/json';
    // heads['Authorization'] = 'Bearer $token';
    // final response = await http.get(
    //     Uri.parse(url +
    //         'api/v1/apply-castings/check?modelId=$modelId&castingId=$castingId'),
    //     headers: heads);
    final response = await http.get(
        Uri.parse(url +
            'api/v1/apply-castings/check?modelId=1&castingId=$castingId'));
    if (response.statusCode == 200) {
      final res = response.body;
      if (res == 'true') {
        return true;
      }
      return false;
    } else {
      throw Exception('Failed to load');
    }
  }
}


