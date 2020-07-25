import 'package:dio/dio.dart';
import '../network.dart';
import 'logger.dart';

/// @description 本class为demo
///
/// @author 燕文强
///
/// @date 2020/7/25
class _RequestWithStateDemo<S, T extends _StatusModel> extends AbsRequestWithState<S, T> {
  void test() {
    _RequestWithStateDemo<String, _MyModel>().send(
      _MyApi.content(),
      onSuccess: (data) {
        print(data.data.cat);
      },
      onFail: (data) {
        print('code:${data.code}，message:${data.message}');
      },
    );
  }

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

        /// 这里可以根据具体业务响应模型来修改
        int dicCode = response.metadata.data['code'];
        String dicMessage = response.metadata.data['message'];
        int code = response.data.code;
        String message = response.data.message;
        onFail(StateBo.businessFail(code: code, message: message));
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
        }
        onFail(StateBo.error());
      },
    );
  }
}

/// 接口响应基础类
class _StatusModel {
  int code;
  String message;
}

class _MyModel extends _StatusModel {
  String cat;
}

class _MyApi<S, T extends _StatusModel> extends Api<S, T> {
  @override
  bool state(dynamic obj) {
    return obj['code'] == 200;
  }

  static _MyApi<String, _MyModel> content() => _MyApi<String, _MyModel>()
    ..method = Method.GET
    ..dataConvert = (data) => _MyModel();
}
