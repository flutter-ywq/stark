import 'package:stark/network/state_bo.dart';
import 'package:stark/network/view/state_view.dart';
import 'package:flutter/cupertino.dart';

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
    @required Function(BuildContext context, T data) completedView,
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
          return completedView(context, asyncSnapshot.data.data);
        }
        if (UIState.noData == uiState) {
          return stateView.noDataView(context);
        }
        if (UIState.loading == uiState) {
          return stateView.loadingView(context);
        }
        if (UIState.networkFailView == uiState) {
          return stateView.networkFailView(context, asyncSnapshot.data);
        }
        if (UIState.noNetwork == uiState) {
          return stateView.noNetworkView(context, asyncSnapshot.data);
        }
        if (UIState.networkPoor == uiState) {
          return stateView.networkPoorView(context, asyncSnapshot.data);
        }
        if (UIState.error == uiState) {
          return stateView.errorView(context, asyncSnapshot.data);
        }
        if (UIState.businessFail == uiState) {
          return stateView.businessFail(context, asyncSnapshot.data);
        }
        return completedView(context, asyncSnapshot.data.data);
      },
    );
  }
}
