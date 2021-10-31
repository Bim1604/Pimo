import 'dart:convert';
import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

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
      print(FirebaseAuth.instance.currentUser.email + ' *****' + idToken);
      var token = {"token": idToken, "mail": mail};
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
        print(parseJson);
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
