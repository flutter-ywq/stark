import 'dart:convert';

/// @description JsonUtils
///
/// @author 燕文强
///
/// @date 2019-09-05
class JsonUtils {
  static Map<String, dynamic> json2Map(String jsonString) {
    return json.decode(jsonString);
  }

  static String map2Json(Map map) {
    return json.encode(map);
  }

  static String getJsonValueForKey(String jsonString, String key) {
    return json2Map(jsonString)[key];
  }
}
