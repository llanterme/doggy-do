import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/models/user_model.dart';
import '../../style.dart';

class Utils {
  static Future<UserModel?> getLocalUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final String? user = preferences.getString("user");
    if (user != null) {
      Map<String, dynamic> userMap = jsonDecode(user);
      UserModel localUser = UserModel.fromJson(userMap);
      print(json.encode(localUser));
      return localUser;
    } else {
      return null;
    }
  }

  static void saveLocalUser(UserModel userModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(json.encode(userModel));
    await preferences.setString('user', json.encode(userModel.toJson()));
  }

  static prettyPrint(Map json) {
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    String pretty = encoder.convert(json);
    return pretty;
  }

  static String generateRandomString(int length) {
    const _chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final Random _rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  static showGenericAlert(
      BuildContext dialogContext, String message, String title) {
    Alert(
      context: dialogContext,
      title: title,
      style: Styles.alertStyle,
      type: AlertType.info,
      desc: message,
      buttons: [
        DialogButton(
            onPressed: () => Navigator.pop(dialogContext),
            color: Styles.buttonColor,
            child: const Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
      ],
    ).show();
  }
}
