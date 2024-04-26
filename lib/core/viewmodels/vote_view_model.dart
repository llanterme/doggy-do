// ignore_for_file: avoid_print

import 'dart:async';
import 'package:doggy_do/core/models/dog_model.dart';
import '../../locator.dart';
import '../enums/viewstate.dart';
import '../network/api.dart';
import 'base_view_model.dart';

class VoteViewModel extends BaseViewModel {
  final Api _api = locator<Api>();

  List<DogModel> dogList = [];
  static int fetchThreshold = 2;

  Future<void> getDogsForVoting(String lastKey) async {
    try {
      setState(ViewState.Busy);

      if (lastKey.isEmpty) {
        dogList = await _api.fetchDogs(fetchThreshold, null);
      } else {
        dogList = await _api.fetchDogs(fetchThreshold, lastKey);
      }

      setState(ViewState.Idle);
    } catch (e) {
      print('Error fetching user activities: $e');
      setState(ViewState.Idle);
      rethrow;
    }
  }
}
