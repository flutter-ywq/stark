import 'dart:async';

/// @description 延迟执行
///
/// @author 燕文强
///
/// @date 2020/6/1
class DelayExecute<T> {
  int delayMilliseconds;
  List<T> _list;
  Function(T result) delayExecute;

  DelayExecute({this.delayMilliseconds = 1000, this.delayExecute});

  void add(T item) {
    if (_list == null) {
      _list = List<T>();
    }
    _list.add(item);
    Future.delayed(Duration(milliseconds: delayMilliseconds), () {
      T element = _list[0];
      _list.removeAt(0);
      if (_list.length <= 0) {
        if (delayExecute != null) {
          delayExecute(element);
        }
      }
    });
  }
}
