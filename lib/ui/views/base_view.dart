import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/viewmodels/base_view_model.dart';
import '../../locator.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final Function(T) onModelReady;

  BaseView({required this.builder, required this.onModelReady});

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  T model = locator<T>();

  @override
  void initState() {
    widget.onModelReady(model);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: model,
      child: Consumer<T>(
        builder: (context, model, child) {
          return widget.builder(context, model, child);
        },
      ),
    );
  }
}
