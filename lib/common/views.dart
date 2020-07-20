import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

/// @description 视图界面常用方法
///
/// @author 燕文强
///
/// @date 2020/7/15
class Views {
  static Future launch(BuildContext context, Widget widget, {bool stack = false}) {
    return Navigator.push(context, _pageRoute(widget, stack));
  }

  static Future launchAndCloseSelf(BuildContext context, Widget widget, {bool stack = false}) {
    return Navigator.pushAndRemoveUntil(context, _pageRoute(widget, stack), (_) => false);
  }

  static bool finish(BuildContext context) {
//  StatefulPage.routes.removeLast();
    return Navigator.pop(context);
  }

  static Route _pageRoute(Widget widget, bool stack) {
    MaterialPageRoute pageRoute = MaterialPageRoute(builder: (context) => Scaffold(body: widget));
//  if (stack) StatefulPage.routes.add(pageRoute);
    return pageRoute;
  }

  static showSnackBar(BuildContext context, String text) {
    return Scaffold.of(context).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 1500),
        content: Text(text),
      ),
    );
  }

  static void toast(
    BuildContext context,
    String msg, {
    int gravity = 1,
    int duration = 2,
    Color backgroundColor = const Color(0xAA000000),
    Color textColor = Colors.white,
    double backgroundRadius = 20,
    Border border,
  }) {
    Toast.show(msg, context,
        duration: duration,
        gravity: gravity,
        backgroundColor: backgroundColor,
        textColor: textColor,
        backgroundRadius: backgroundRadius,
        border: border);
  }
}
