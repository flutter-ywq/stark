import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:convert/convert.dart';

/// @description 加密工具
///
/// @author 燕文强
///
/// @date 2019-09-09
class EncryptUtils {
  /// md5加密
  static String generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    // 这里其实就是 digest.toString()
    return hex.encode(digest.bytes);
  }

  /// base64加密
  static String encodeBase64(String data) {
    var content = utf8.encode(data);
    var digest = base64Encode(content);
    return digest;
  }

  /// base64解密
  static String decodeBase64(String data) {
    return String.fromCharCodes(base64Decode(data));
  }

  /// 通过图片路径将图片转换成base64字符串
  static Future image2Base64(String path) async {
    File file = new File(path);
    List<int> imageBytes = await file.readAsBytes();
    return base64Encode(imageBytes);
  }

  /// 通过图片路径将图片转换成base64字符串
  static String image2Base64Sync(String path) {
    File file = new File(path);
    List<int> imageBytes = file.readAsBytesSync();
    return base64Encode(imageBytes);
  }
}
