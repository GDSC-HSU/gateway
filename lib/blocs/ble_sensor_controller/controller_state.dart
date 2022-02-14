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
  final String mess;
  final SensorState? currentError;
  final List<SensorState> listOfSensorState;

  HexoState(
      {required this.isDone,
      required this.mess,
      required this.listOfSensorState,
      this.currentError});
}

class HexoStateProcessing {
  late Map<SensorType, SensorState> _state;

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

  addEvent(BleSensorControllerSensorDataEvent event) {
    if (_state[event.sensorType] == null) {
      _state[event.sensorType] = SensorState(event);
    }
  }

  // TODO use formbinding @@ insteed of this implamation
  _processState() {
    Map<SensorType, bool> _stateTracking = {};
    _state.keys.toList().map((e) => _stateTracking[e] = false);
    _state.forEach((key, value) {
      if (value.isNull) {
        streamStateController.sink.add(HexoState(
            mess: "",
            isDone: false,
            listOfSensorState: _state.values.toList(),
            currentError: value));
        // emit base on that sensor
        return;
      } else {
        _stateTracking[key] = true;
      }
    });
    bool allDone = _stateTracking.values.toList().every((element) => true);
    if (allDone) {
      streamStateController.sink.add(HexoState(
        mess: "",
        isDone: true,
        listOfSensorState: _state.values.toList(),
      ));
    }
  }

  _stepTracking() {}
}
