import 'package:flutter/cupertino.dart';

/// @description 视图生命周期
///
/// @author 燕文强
///
/// @date 2020/7/27
mixin Lifecycle {
  void prepare(BuildContext context);

  void viewDidLoad(BuildContext context);

  void dispose(BuildContext context);
}
