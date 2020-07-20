import 'dart:async';
import 'package:stark/network/utils/logger.dart';
import 'package:stark/stream/state_bo.dart';
import 'deliver.dart';
import 'net/api.dart';
import 'net/requester.dart';

/// @description Observable
///
/// @author 燕文强
///
/// @date 2019-12-30
class Observable<S extends Api, T extends StateBo> {
  final StreamController<S> streamController = StreamController<S>();

  Stream<S> get stream => streamController.stream;

  StreamSink<S> get _sink => streamController.sink;
  StreamTransformer<S, T> _transformer;
  final S api;
  Deliver deliver;
  Function() _onSubscribe;
  Function() _onCompleted;

  Observable({this.api, this.deliver}) {
    _transformer = StreamTransformer<S, T>.fromHandlers(handleData: (value, sink) {
      Request(
          api: value,
          onStart: (api) {
            _onSubscribe();
          },
          onSuccess: (response) {
            _onCompleted();
            deliver.applySuccess<T>(sink, response);
          },
          onFail: (response) {
            _onCompleted();
            deliver.applyFail<T>(sink, response);
          },
          onError: (error) {
            _onCompleted();
            deliver.applyError<T>(sink, error);
          },
          onCatchError: (error) {
            _onCompleted();
            deliver.applyCatchError<T>(sink, error);
          });
    });
  }

  Stream<T> compose() {
    return streamController.stream.transform(_transformer);
  }

  void subscribe(
      {void Function() onSubscribe,
      void Function(T data) onData,
      void Function(dynamic error) onError,
      void Function() onCompleted}) {
    if (_transformer == null) {
      Net.logFormat('_transformer cannot be empty');
      return;
    }
    if (deliver == null) {
      deliver = ApiDeliver();
    }
    _onSubscribe = onSubscribe;
    _onCompleted = onCompleted;
    streamController.stream.transform(_transformer).listen(onData, onError: onError, onDone: () => dispose());
    streamController.add(api);
  }

  void dispose() {
    streamController.close();
  }
}
