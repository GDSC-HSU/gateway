import 'package:gateway/blocs/ble_sensor/ble_sensor.dart';
import 'package:gateway/blocs/ble_sensor_controller/bloc/gateway_controller_bloc.dart';
import 'package:gateway/extension.dart';
import 'package:gateway/model/device_sensor.dart';
import 'package:reactive_forms/reactive_forms.dart';

enum FromType { temperature, identification, maskCamera, qrCamera }

class HexoStateForm {
  late FormGroup form;

  HexoStateForm() {
    form = FormGroup(_createFormControlForBLEData());
  }

  bool get isProvideCovidIdentificationMethod {
    return form.controls[FromType.identification.name]!.valid ||
        form.controls[FromType.qrCamera.name]!.valid;
  }

  Map<String, FormControl> _createFormControlForBLEData() {
    // TODO custome required and not required
    final from = FromType.values.asNameMap().map((key, value) {
      switch (value) {
        case FromType.identification:
          return MapEntry(value.name,
              FormControl<String>(validators: [Validators.required]));
        case FromType.maskCamera:
          return MapEntry(
              value.name,
              FormControl<bool>(
                  validators: [Validators.required, Validators.requiredTrue]));
        case FromType.qrCamera:
          // TODO ADD OR comparation with rfid identification
          return MapEntry(value.name,
              FormControl<String>(validators: [Validators.required]));
        case FromType.temperature:
          return MapEntry(
              value.name,
              FormControl<double>(validators: [
                Validators.required,
              ]));
      }
    });
    return from;
  }

  addBLEDataToForm(GatewayControllerBLESensorDataEvent event) {
    dynamic data = event.data.asBLEData;
    final fromType = _bleToFromType(event.sensorType);
    data = fromValue(fromType, data);
    form.controls[fromType.name]?.updateValue(data);
    print([event.sensorType.name, form.controls[fromType.name]!.value]);
  }

  Object fromValue(FromType type, dynamic data) {
    dynamic transformedData = data;
    switch (type) {
      case FromType.identification:
        return _dataType<String>(type, transformedData);
      case FromType.maskCamera:
        return _dataType<bool>(type, transformedData);
      case FromType.qrCamera:
        return _dataType<String>(type, transformedData);
      case FromType.temperature:
        transformedData = double.parse(transformedData);
        return _dataType<double>(type, transformedData);
      default:
        throw "[DEV] : fromType not supported" + type.name;
    }
  }

  T _dataType<T>(FromType type, T value) {
    return value;
  }

  addHardWareSensorToForm(dynamic data, FromType type) {
    data = fromValue(type, data);
    form.controls[type.name]?.updateValue(data);
  }

  FromType _bleToFromType(SensorType sensorType) {
    switch (sensorType) {
      case SensorType.rfid:
        return FromType.identification;
      case SensorType.temperature:
        return FromType.temperature;
      default:
        throw "[DEV] FromType not support " + sensorType.name;
    }
  }

  DeviceSensorData toSensorData() {
    return DeviceSensorData.fromFromData(form.rawValue);
  }

  resetFrom() {
    form.reset();
    form.markAsPristine();
  }

  bool customControllerStatusValid() {
    final isBool = isProvideCovidIdentificationMethod &&
        form.controls[FromType.maskCamera.name]!.valid &&
        form.controls[FromType.temperature.name]!.valid;
    return isBool;
  }

  get formValue => form.value;

  Stream<ControlStatus> get controlStatusStream => form.statusChanged;
}
