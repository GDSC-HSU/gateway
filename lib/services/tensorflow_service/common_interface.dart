import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

///
/// T as input data for tensorflow inference
/// R as data output (label) :>
///
abstract class ITensorFlowCommon<T, R> {
  /// common pub sub
  final BehaviorSubject<R> inferenceOutput$ = BehaviorSubject();
  StreamSink<R> get sink => inferenceOutput$.sink;
  ValueStream<R> get stream => inferenceOutput$.stream;

  ///

  /// common method
  bool isBusy = false;
  Future<void> initModel();
  Future<void> dispose() async {
    await inferenceOutput$.close();
    return;
  }

  Future<void> inference(T data);
}
