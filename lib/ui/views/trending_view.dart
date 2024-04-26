import 'package:doggy_do/core/models/user_model.dart';
import 'package:doggy_do/style.dart';
import 'package:flutter/material.dart';
import '../../core/enums/viewstate.dart';

import '../../core/viewmodels/register_view_model.dart';
import 'base_view.dart';

class TrendingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterViewModel>(
        onModelReady: (RegisterViewModel) {},
        builder: (context, model, child) => Scaffold(
            body: model.state == ViewState.Busy
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: Center(),
                  )));
  }
}
