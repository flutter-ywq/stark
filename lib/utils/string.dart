/// @description String相关操作的工具
///
/// @author 燕文强
///
/// @date 2019-09-02

/// 空字符串，避免没必要的开辟内存空间
const String Empty = '';

bool nullOrEmpty(String value) {
  if (value == null) {
    return true;
  }
  if (value.isEmpty) {
    return true;
  }
  return false;
}

String null2Empty(String value) {
  if (value == null) {
    return Empty;
  }
  return value;
}
