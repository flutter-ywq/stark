import 'package:stark/bloc/state_view.dart';
import 'package:flutter/cupertino.dart';

import '../network/state_bo.dart';

/// @description StateStreamBuilder
///
/// @author 燕文强
///
/// @date 2020/7/16
class StateStreamBuilder {
  static StreamBuilder<StateBo<T>> create<T>({
    Key key,
    StateBo<T> initialData,
    Stream<StateBo<T>> stream,
    @required StateView stateView,
    @required Function(T data) completedView,
  }) {
    assert(stateView != null, 'stateView must not is null !');
    assert(completedView != null, 'completedView must not is null !');
    return StreamBuilder<StateBo<T>>(
      key: key,
      // default loading state
      initialData: initialData == null ? StateBo.loading() : initialData,
      stream: stream,
      builder: (context, asyncSnapshot) {
        UIState uiState = asyncSnapshot.data.uiState;
        if (UIState.completed == uiState) {
          return completedView(asyncSnapshot.data.data);
        }
        if (UIState.noData == uiState) {
          return stateView.noDataView();
        }
        if (UIState.loading == uiState) {
          return stateView.loadingView();
        }
        if (UIState.networkFailView == uiState) {
          return stateView.networkFailView();
        }
        if (UIState.noNetwork == uiState) {
          return stateView.noNetworkView();
        }
        if (UIState.networkPoor == uiState) {
          return stateView.networkPoorView();
        }
        if (UIState.error == uiState) {
          return stateView.errorView();
        }
        return completedView(asyncSnapshot.data.data);
      },
    );
  }
}
