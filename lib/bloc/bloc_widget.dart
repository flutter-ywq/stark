import 'package:stark/bloc/state_view.dart';
import 'package:stark/common/views.dart';
import 'package:stark/network/state_bo.dart';
import 'package:stark/stream/state_stream_builder.dart';
import 'package:stark/utils/logger.dart';
import 'package:flutter/material.dart';
import 'bloc_view.dart';

/// @description BlocWidget基类
///
/// @author 燕文强
///
/// @date 2020/7/14
abstract class BlocWidget<T extends Bloc> extends StatefulWidget {
  final T bloc;

  BlocWidget(this.bloc, {Key key}) : super(key: key) {
    assert(bloc != null, 'bloc must not is null');
  }

  String get title;

  BlocState<BlocWidget<T>> state();

  @override
  State<StatefulWidget> createState() => state();
}

/// @description BlocState基类
///
/// @author 燕文强
///
/// @date 2020/7/14
abstract class BlocState<T extends BlocWidget> extends State<T> with BlocView, WidgetsBindingObserver, StateView {
  bool _bindingObserver;

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
    if (_bindingObserver) {
      logFormat('remove WidgetsBindingObserver');
      WidgetsBinding.instance.removeObserver(this);
    }
  }

  void retry() {
    widget.bloc.retry();
  }

  @override
  void initState() {
    super.initState();
    _bindingObserver = isBindingObserver();
    prepare();
    if (_bindingObserver) {
      logFormat('bind WidgetsBindingObserver');
      WidgetsBinding.instance.addObserver(this);
    }

    WidgetsBinding.instance.addPostFrameCallback((callback) {
      viewDidLoad(callback);
    });
  }

  bool isBindingObserver() => false;

  viewDidLoad(callback);

  void prepare();

  StreamBuilder<StateBo<M>> streamBuilder<M>({
    Key key,
    StateBo<M> initialData,
    Stream<StateBo<M>> stream,
    @required Function(M data) completedView,
  }) {
    assert(completedView != null, 'completedView must not is null !');
    return StateStreamBuilder.create(
      key: key,
      initialData: initialData,
      stream: stream,
      stateView: this,
      completedView: completedView,
    );
  }

  @override
  void didChangeAccessibilityFeatures() {}

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    logFormat('lifecycle changed: $state');
  }

  @override
  void didChangeLocales(List<Locale> locale) {}

  @override
  void didChangeMetrics() {}

  @override
  void didChangePlatformBrightness() {}

  @override
  void didChangeTextScaleFactor() {}

  @override
  void didHaveMemoryPressure() {}

  @override
  bool finish() {
    return Views.finish(context);
  }

  @override
  BuildContext getContext() => this.context;

  @override
  Future launch(Widget widget, {bool stack = false}) {
    return Views.launch(context, widget, stack: stack);
  }

  @override
  Future launchAndCloseSelf(Widget widget, {bool stack = false}) {
    return Views.launchAndCloseSelf(context, widget, stack: stack);
  }

  @override
  void toast(String msg,
      {int gravity = 1,
      int duration = 1,
      Color backgroundColor = const Color(0xAA000000),
      Color textColor = Colors.white,
      double backgroundRadius = 20,
      Border border}) {
    Views.toast(context, msg,
        gravity: gravity,
        duration: duration,
        backgroundColor: backgroundColor,
        textColor: textColor,
        backgroundRadius: backgroundRadius,
        border: border);
  }
}

/// @description Bloc基类
///
/// @author 燕文强
///
/// @date 2020/7/14
abstract class Bloc {
  void retry();

  void dispose();
}
