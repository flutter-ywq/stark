import 'package:dio/dio.dart';
import '../net/api.dart';
import '../net/requester.dart';
import '../state_bo.dart';
import 'logger.dart';

/// @description 待描述
///
/// @author 燕文强
///
/// @date 2020/7/22

abstract class AbsRequestWithState<S, T> {
  void send(
    Api<S, T> api, {
    Function(Api<S, T> api) onStart,
    Function onCompleted,
    Function(StateBo<T> data) onSuccess,
    Function(StateBo<T> data) onFail,
  });
}

class RequestWithState<S, T> extends AbsRequestWithState<S, T> {
  @override
  void send(
    Api<S, T> api, {
    Function(Api<S, T> api) onStart,
    Function onCompleted,
    Function(StateBo<T> data) onSuccess,
    Function(StateBo<T> data) onFail,
  }) {
    Request<S, T>(
      api: api,
      onStart: (api) {
        if (onStart != null) onStart(api);
      },
      onSuccess: (response) {
        if (onCompleted != null) onCompleted();
        onSuccess(StateBo<T>(response.data));
      },
      onFail: (response) {
        if (onCompleted != null) onCompleted();
        onFail(StateBo.businessFail(code: 120, message: response.data.toString())..data = response.data);
      },
      onError: (error) {
        if (onCompleted != null) onCompleted();
        if (error.runtimeType is DioError) {
          DioError dioError = error;
          int statusCode = dioError.response.statusCode + 1000;
          Net.logFormat('request error status code:$statusCode');
          onFail(StateBo.networkFail(code: statusCode));
        } else {
          Net.logFormat('request error:${error.toString()}');
          onFail(StateBo.networkFail(code: 119, message: error.toString()));
        }
      },
      onCatchError: (error) {
        if (onCompleted != null) onCompleted();
        Net.logFormat('catch error:${error.toString()}');
        if (error.runtimeType is CastError) {
          onFail(StateBo.error(code: 110, message: error.toString()));
          return;
        }
        onFail(StateBo.error());
      },
    );
  }
}
