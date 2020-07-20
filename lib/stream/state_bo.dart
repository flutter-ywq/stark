/// @description 具有状态的数据模型
///
/// @author 燕文强
///
/// @date 2020/7/16
class StateBo<T> {
  T data;
  UIState uiState;

  /// 默认完成状态
  StateBo(this.data, {this.uiState = UIState.completed});

  StateBo.loading() {
    this.uiState = UIState.loading;
  }

  StateBo.noNetwork() {
    this.uiState = UIState.noNetwork;
  }

  StateBo.networkPoor() {
    this.uiState = UIState.networkPoor;
  }

  StateBo.error() {
    this.uiState = UIState.error;
  }

  StateBo.noData() {
    this.uiState = UIState.noData;
  }

  StateBo.networkFail() {
    this.uiState = UIState.networkFailView;
  }
}

enum UIState {
  /// 无网络状态
  noNetwork,

  /// 网络差
  networkPoor,

  /// 获取数据失败（超时、500错误等）
  networkFailView,

  /// 加载中
  loading,

  /// 出错了
  error,

  /// 无数据
  noData,

  /// 完成预期
  completed,
}
