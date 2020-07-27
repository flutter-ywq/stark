//import 'package:bloc_flutter/bloc_provider/bloc.dart';
//import 'package:bloc_flutter/bloc_provider/provider.dart';
//import 'package:bloc_flutter/bloc_provider/lifecycle.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'bloc.dart';
import 'provider.dart';
import 'lifecycle.dart';

/// @description 待描述
///
/// @author 燕文强
///
/// @date 2020/7/24

abstract class BlocWidget<T extends BlocBase> extends StatelessWidget with WidgetsBindingObserver, ViewLifecycle {
  String get title;

  bool get bindingObserver => false;

  @override
  Widget build(BuildContext context) {
    T bloc = BlocProvider.of<T>(context);
    return widget(context, bloc);
  }

  void retry(T bloc) {
    bloc.retry();
  }

  Widget widget(BuildContext context, final T bloc);

  @override
  void viewDidLoad(BuildContext context) {}

  @override
  void dispose(BuildContext context) {}
}
