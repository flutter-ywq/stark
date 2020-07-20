import 'package:flutter/material.dart';

/// @description BlocView基类
///
/// @author 燕文强
///
/// @date 2020/7/15
mixin BlocView {
  void toast(
    String msg, {
    int gravity = 1,
    int duration = 1,
    Color backgroundColor = const Color(0xAA000000),
    Color textColor = Colors.white,
    double backgroundRadius = 20,
    Border border,
  });

  Future launch(Widget widget, {bool stack = false});

  Future launchAndCloseSelf(Widget widget, {bool stack = false});

  BuildContext getContext();

  bool finish();
}
