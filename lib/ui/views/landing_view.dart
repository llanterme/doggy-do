import 'package:doggy_do/core/viewmodels/landing_view_model.dart';
import 'package:doggy_do/ui/views/trending_view.dart';
import 'package:doggy_do/ui/views/vote_view.dart';
import 'package:flutter/material.dart';
import '../../core/enums/viewstate.dart';

import 'base_view.dart';

class LandingView extends StatelessWidget {
  int _currentIndex = 0;

  final List<Widget> _tabs = [VoteView(), TrendingView()];

  @override
  Widget build(BuildContext context) {
    return BaseView<LandingViewModel>(
        onModelReady: (RegisterViewModel) {},
        builder: (context, model, child) => Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (int index) {
                model.setState(ViewState.Idle);
                _currentIndex = index;
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.how_to_vote_outlined),
                  label: 'vote',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.trending_flat_outlined),
                  label: 'trending',
                ),
              ],
            ),
            body: _tabs[_currentIndex]));
  }
}
