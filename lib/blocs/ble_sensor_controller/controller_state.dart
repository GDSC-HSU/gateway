// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:async';

import 'package:gateway/blocs/ble_sensor/ble_sensor.dart';
import 'package:gateway/blocs/ble_sensor_controller/bloc/ble_sensor_controller_bloc.dart';

// TODO ADD Rule for isDone 15cm < 25cm , temp
class SensorState {
  late final bool isDone;
  bool get isNull => sensor.data.isEmpty;
  SensorType get sensorType => sensor.sensorType;
  final BleSensorControllerSensorDataEvent sensor;
  SensorState(this.sensor);
}

///
// H is for handy, the helpful you.

// E is for enthusiasm, in even the most dire circumstances

// X is for Xanadu, your place of paradise.

// O is for openness, it's refreshing!
///
class HexoState {
  final bool isDone;
  final String? mess;
  final SensorState? currentError;
  final List<SensorState> listOfSensorState;

  HexoState(
      {required this.isDone,
      this.mess,
      required this.listOfSensorState,
      this.currentError});
}

class HexoStateProcessing {
  Map<SensorType, SensorState> _state = {};
  late Map<SensorType, bool> _stateTracking = {};

  final StreamController<HexoState> streamStateController = StreamController();

  bool isReset = false;
  bool isStart = false;
  HexoStateProcessing();

  _initTimer() {
    Timer.periodic(new Duration(seconds: 1), (timer) {
      // start
      // stop
      // reset
    });
  }

  resetState() {
    if (isReset) {
      _initState();
    }
  }

  addEvent(BleSensorControllerSensorDataEvent event) {
    if (_state[event.sensorType] == null) {
      _state[event.sensorType] = SensorState(event);
    }
  }

  _initState() {
    // _state.keys.toList().map((e) => _stateTracking[e] = false);
    // _state.forEach((key, value) {
    //   if (value.isNull) {
    //     streamStateController.sink.add(HexoState(
    //         mess: "",
    //         isDone: false,
    //         listOfSensorState: _state.values.toList(),
    //         currentError: value));
    //     // emit base on that sensor
    //     return;
    //   } else {
    //     // condition like proximity 15-20cm
    //     _stateTracking[key] = true;
    //   }
    // });
    _state.keys.forEach((e) => _stateTracking[e] = false);
  }

  _processSensorHasData() {
    _state.forEach((key, value) {
      if (!value.isNull) {
        _stateTracking[key] = true;
      }
    });
  }

  // TODO use formbinding @@ insteed of this implamation
  processState() {
    _processSensorHasData();
    bool isAllSensorHasData =
        _stateTracking.values.toList().every((element) => true);
    bool allDone = _sensorRule();
    if (allDone) {
      streamStateController.sink.add(HexoState(
        mess: "",
        isDone: true,
        listOfSensorState: _state.values.toList(),
      ));
    } else {
      _stepTracking();
    }
  }

  _stepTracking() {
    // step tracking error code
    final failedStep =
        _stateTracking.entries.where((element) => element.value == false);
    if (failedStep.isNotEmpty) {
      final firstFailedStep = _state[failedStep.first.key];
      streamStateController.add(HexoState(
        isDone: false,
        mess: "MOCK",
        currentError: firstFailedStep,
        listOfSensorState: _state.values.toList(),
      ));
    }
  }

  bool _sensorRule() {
    return true;
  }
}
