import 'dart:async';
import 'package:stark/network/net/api.dart';
import 'package:stark/network/net/requester.dart';
import 'package:stark/network/utils/logger.dart';
import 'package:stark/stream/state_bo.dart';
import 'package:dio/dio.dart';
import '../network/deliver.dart';

/// @description RequestStreamController
///
/// @author 燕文强
///
/// @date 2019-12-30
class RequestStreamController<S extends Api, T> {
  Stream<StateBo<T>> stream;

  final StreamController<S> _controller = StreamController<S>();
  Function() _onStart;
  Function() _onCompleted;

  RequestStreamController() {
    StreamTransformer<S, StateBo<T>> transformer = StreamTransformer<S, StateBo<T>>.fromHandlers(handleData: (value, sink) {
      Request(
          api: value,
          onStart: (api) {
            sink.add(StateBo.loading());
            if (_onStart != null) _onStart();
          },
          onSuccess: (response) {
            if (_onCompleted != null) _onCompleted();
            sink.add(StateBo<T>(response.data));
          },
          onFail: (response) {
            if (_onCompleted != null) _onCompleted();
            sink.add(StateBo.networkFail());
          },
          onError: (error) {
            if (error.runtimeType is DioError) {
              DioError dioError = error;
              int statusCode = dioError.response.statusCode;
              Net.logFormat('request error status code:$statusCode');
            } else {
              Net.logFormat('request error:${error.toString()}');
            }
            if (_onCompleted != null) _onCompleted();
            sink.add(StateBo.error());
          },
          onCatchError: (error) {
            Net.logFormat('catch error:${error.toString()}');
            if (_onCompleted != null) _onCompleted();
            sink.add(StateBo.error());
          });
    });
    stream = _controller.stream.transform(transformer);
  }

  add(S api, {Function onStart, Function onCompleted}) {
    _onStart = onStart;
    _onCompleted = onCompleted;
    _controller.add(api);
  }

  void close() {
    _controller.close();
  }
}
