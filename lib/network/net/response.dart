import 'package:dio/dio.dart';

/// @description 响应数据
///
/// @author 燕文强
///
/// @date 2019-09-02
class ResponseData<T> {
  Response metadata;
  T data;

  ResponseData({this.metadata, this.data});

  @override
  String toString() {
    return 'ResponseData{response: $metadata, data: $data}';
  }
}
