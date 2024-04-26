// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

import 'package:doggy_do/core/models/user_model.dart';

import '../../locator.dart';
import '../enums/viewstate.dart';
import '../network/api.dart';
import 'base_view_model.dart';

class RegisterViewModel extends BaseViewModel {
  final Api _api = locator<Api>();

  Future<bool> uploadImage(
      String imagePath, String fileName, UserModel user) async {
    try {
      setState(ViewState.Busy);

      final file = File(imagePath);
      final bytes = await file.readAsBytes();

      String response = await _api.uploadImage(bytes, fileName, user);
      setState(ViewState.Idle);
      if (response == "OK") {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      setState(ViewState.Idle);
      return false;
    }
  }
}
