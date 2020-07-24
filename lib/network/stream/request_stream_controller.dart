import 'dart:async';
import 'package:stark/network/net/api.dart';
import 'package:stark/network/net/requester.dart';
import 'package:stark/network/utils/logger.dart';
import 'package:stark/network/state_bo.dart';
import 'package:dio/dio.dart';

/// @description RequestStreamController
///
/// @author 燕文强
///
/// @date 2019-12-30
class RequestStreamController<S, T> {
  Stream<StateBo<T>> stream;

  final StreamController<Api<S, T>> _controller = StreamController<Api<S, T>>();
  Function() _onStart;
  Function() _onCompleted;

  RequestStreamController() {
    StreamTransformer<Api<S, T>, StateBo<T>> transformer =
        StreamTransformer<Api<S, T>, StateBo<T>>.fromHandlers(handleData: (value, sink) {
      Request<S, T>(
          api: value,
          onStart: (api) {
            if (_onStart != null) _onStart();
            sink.add(StateBo.loading());
          },
          onSuccess: (response) {
            if (_onCompleted != null) _onCompleted();
            sink.add(StateBo<T>(response.data));
          },
          onFail: (response) {
            if (_onCompleted != null) _onCompleted();
            sink.add(StateBo.businessFail(code: 120, message: response.data.toString())..data = response.data);
          },
          onError: (error) {
            if (_onCompleted != null) _onCompleted();
            if (error.runtimeType is DioError) {
              DioError dioError = error;
              int statusCode = dioError.response.statusCode;
              Net.logFormat('request error status code:$statusCode');
              sink.add(StateBo.networkFail(code: statusCode));
            } else {
              Net.logFormat('request error:${error.toString()}');
              // 万能的119
              sink.add(StateBo.networkFail(code: 119, message: error.toString()));
            }
          },
          onCatchError: (error) {
            if (_onCompleted != null) _onCompleted();
            Net.logFormat('catch error:${error.toString()}');
            if (error.runtimeType is CastError) {
              sink.add(StateBo.error(code: 110, message: error.toString()));
              return;
            }
            sink.add(StateBo.error(code: 114, message: error.toString()));
          });
    });
    stream = _controller.stream.transform(transformer);
  }

  add(Api<S, T> api, {Function onStart, Function onCompleted}) {
    _onStart = onStart;
    _onCompleted = onCompleted;
    _controller.add(api);
  }

  void close() {
    _controller.close();
  }
}
