import 'package:flutter/cupertino.dart';

/// @description 待描述
///
/// @author 燕文强
///
/// @date 2020/7/27
mixin ViewLifecycle {
  void prepare(BuildContext context);

  void viewDidLoad(BuildContext context);

  void dispose(BuildContext context);
}
