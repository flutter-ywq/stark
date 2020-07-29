import 'dart:async';
import 'package:stark/network/state_bo.dart';

/// @description BlocStreamController
///
/// @author 燕文强
///
/// @date 2020/7/16
class StateStreamController<T> {
  StreamController<StateBo<T>> controller;

  StateStreamController() {
    controller = StreamController<StateBo<T>>();
  }

  Stream<StateBo<T>> get stream => controller.stream;

  StreamSink<StateBo<T>> get _sink => controller.sink;

  void add(StateBo<T> item) {
    if (!controller.isClosed && !controller.isPaused) {
      _sink.add(item);
    }
  }

  close() {
    controller.close();
  }
}
