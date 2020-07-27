import 'package:flutter/cupertino.dart';
import 'bloc.dart';
import 'widget.dart';

/// @description Bloc方式提供者，以Provider来粘合页面和Bloc逻辑
///
/// @author 燕文强
///
/// @date 2020/7/13
class BlocProvider<T extends BlocBase> extends StatefulWidget {
  final T bloc;
  final BlocWidget child;

  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }) : super(key: key);

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends BlocBase>(BuildContext context) {
    BlocProvider<T> provider = context.findAncestorWidgetOfExactType();
    return provider.bloc;
  }
}

class _BlocProviderState<T> extends State<BlocProvider<BlocBase>> {
  @override
  void initState() {
    super.initState();
    if (widget.child.bindingObserver) {
      WidgetsBinding.instance.addObserver(widget.child);
    }
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      widget.child?.viewDidLoad(context);
    });
  }

  @override
  void dispose() {
    widget.bloc?.dispose();
    if (widget.child.bindingObserver) {
      print('remove WidgetsBindingObserver');
      WidgetsBinding.instance.removeObserver(widget.child);
    }
    widget.child?.dispose(context);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
