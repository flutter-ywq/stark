import 'dart:async';
import 'package:stark/network/state_bo.dart';

/// @description BlocStreamController
///
/// @author 燕文强
///
/// @date 2020/7/16
class StateStreamController<T extends StateBo> {
  StreamController<T> controller;

  StateStreamController() {
    controller = StreamController<T>();
  }

  Stream<T> get stream => controller.stream;

  StreamSink<T> get _sink => controller.sink;

  void add(T item) {
    if (!controller.isClosed || controller.isPaused) {
      _sink.add(item);
    }
  }

  close() {
    controller.close();
  }
}
