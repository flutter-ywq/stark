//import 'package:bloc_flutter/bloc_provider/bloc_base.dart';
//import 'package:bloc_flutter/bloc_provider/bloc_provider.dart';
//import 'package:bloc_flutter/bloc_provider/lifecycle.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'bloc_base.dart';
import 'bloc_provider.dart';
import 'lifecycle.dart';

/// @description BlocWidget View层
///
/// @author 燕文强
///
/// @date 2020/7/24

abstract class BlocWidget<T extends BlocBase> extends StatelessWidget with WidgetsBindingObserver, Lifecycle {
  String get title;

  bool get bindingObserver => false;

  @override
  Widget build(BuildContext context) {
    T bloc = BlocProvider.of<T>(context);
    return widget(context, bloc);
  }

  T bloc(BuildContext context) {
    return BlocProvider.of<T>(context);
  }

  void retry(T bloc) {
    bloc.retry();
  }

  Widget widget(BuildContext context, final T bloc);

  @override
  void prepare(BuildContext context) {}

  @override
  void viewDidLoad(BuildContext context) {}

  @override
  void dispose(BuildContext context) {}
}
