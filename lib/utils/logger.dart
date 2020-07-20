/// @description logger顶级方法
///
/// @author 燕文强
///
/// @date 2019-09-02
bool _logAble = true;

/// 开启日志打印
logEnable() => _logAble = true;

/// 关闭日志打印
logDisable() => _logAble = false;

/// 打印日志
void log(Object object) {
  _log(getStackTraceOffset(3, 4));
  _log(object);
}

/// 格式化打印
void logFormat(Object object) {
  String where = getStackTraceOffset(3, 4);
  _format(where, object);
}

void _log(Object object) {
  if (_logAble) {
    print(object);
  }
}

void _format(String where, Object object) {
  _log(
      '┌--------------------------------------------------------------------------------------------');
  _log('| $where');
  _log('├--------------------');
  _log('| $object');
  _log(
      '└--------------------------------------------------------------------------------------------');
  _log('\n');
}

/// 获取堆栈信息
String getStackTrace() => StackTrace.current.toString();

/// 获取偏移量堆栈信息
String getStackTraceOffset(int startLine, int endLine) {
  String result = getStackTrace()
      .split('#$startLine')[1]
      .split('#$endLine')[0]
      .trim()
      .replaceAll('\n', '');

  return result;
}

/// 打印堆栈信息
void logStack() {
  String stack = getStackTrace();
  String where = getStackTraceOffset(3, 4);
  _format(where, '【堆栈信息】\n$stack');
}
