import 'package:flutter/material.dart';

/// @description 屏幕尺寸
///
/// @author 燕文强
///
/// @date 2020/7/18
class Screen {
  /// 屏幕宽度
  static double width(BuildContext context) => MediaQuery.of(context).size.width;

  /// 屏幕高度
  static double height(BuildContext context) => MediaQuery.of(context).size.height;

  /// 导航栏高度
  static double get navHeight => AppBar().preferredSize.height;

  /// 电池条高度
  static double statusBarHeight(BuildContext context) => MediaQuery.of(context).padding.top;

  /// 底部安全高度，
  static double safeAreaHeight(BuildContext context) => MediaQuery.of(context).padding.bottom;

  /// contentHeight高度 = height - navHeight - statusBarHeight-safeAreaHeight
  static double contentHeight(BuildContext context) =>
      (height(context) - statusBarHeight(context) - navHeight - safeAreaHeight(context));
}
