import 'dart:convert';
import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jwt_decode/jwt_decode.dart';

import 'package:pimo/module/deprecated/flutter_session/flutter_session.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount _user;

  GoogleSignInAccount get user => _user;

  Future googleLogin() async {
    try {
      // await logout();
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;
      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      var idToken = await FirebaseAuth.instance.currentUser.getIdToken();
      var mail = await FirebaseAuth.instance.currentUser.email;
      var token = {"token": idToken, "mail": mail};
      await FlutterSession().set("token", idToken);
      HttpClient client = HttpClient();
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      var url = 'https://api.pimo.studio/api/v1/auth';
      HttpClientRequest request = await client.postUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(json.encode(token)));
      HttpClientResponse response = await request.close();
      String reply = await response.transform(utf8.decoder).join();
      final parseJson = jsonDecode(reply);
      if (parseJson['isExist'] == false) {
        Fluttertoast.showToast(
            msg: "Rất tiếc, bạn không thuộc trong hệ thống.\n Hãy đăng kí với admin. ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1
        );
        return logout();
      } else {
        Map<String, dynamic> payload = Jwt.parseJwt(parseJson['jwt']);

        await FlutterSession().set("jwt", parseJson['jwt']);
        print("JWT:" + await FlutterSession().get("jwt"));
        var linkModelId = 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier';
        await FlutterSession().set("modelId", payload[linkModelId]);
        await FlutterSession().set("modelName", parseJson['name']);
        Fluttertoast.showToast(
            msg: "Đăng nhập thành công",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1
        );
      }
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }

  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
