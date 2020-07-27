import 'package:flutter/material.dart';
import 'package:stark/network/state_bo.dart';

/// @description StateView 以状态为维度的视图
///
/// @author 燕文强
///
/// @date 2020/7/17
mixin StateView {
  /// 无网络状态视图
  Widget noNetworkView(BuildContext context, StateBo data);

  /// 网络差状态视图
  Widget networkPoorView(BuildContext context, StateBo data);

  /// 获取数据失败（超时、500错误等）
  Widget networkFailView(BuildContext context, StateBo data);

  /// 加载状态视图
  Widget loadingView(BuildContext context);

  /// 错误状态视图
  Widget errorView(BuildContext context, StateBo data);

  /// 无数据状态视图
  Widget noDataView(BuildContext context);

  /// 业务处理失败
  Widget businessFail(BuildContext context, StateBo data);
}
