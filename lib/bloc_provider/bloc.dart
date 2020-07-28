import 'package:flutter/cupertino.dart';

/// @description BlocBase
///
/// @author 燕文强
///
/// @date 2020/7/13
abstract class BlocBase {
  void prepare();

  void retry();

  void dispose();
}
