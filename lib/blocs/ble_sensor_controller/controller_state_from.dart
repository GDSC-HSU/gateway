import 'package:gateway/blocs/ble_sensor/ble_sensor.dart';
import 'package:gateway/blocs/ble_sensor_controller/bloc/gateway_controller_bloc.dart';
import 'package:gateway/extension.dart';
import 'package:reactive_forms/reactive_forms.dart';

enum FromType { temperature, identification, maskCamera, qrCamera }

class HexoStateForm {
  late FormGroup form = FormGroup(_createFormControlForBLEData());

  FormControl getBLEFormControl(FromType type) {
    return form.controls[type.name] as FormControl;
  }

  static Map<String, FormControl> _createFormControlForBLEData() {
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

  resetFrom() {
    form.reset();
  }

  get formValue => form.value;

  Stream<ControlStatus> get controlStatusStream => form.statusChanged;
}

var mockData = SensorType.values
    .map((e) => GatewayControllerBLESensorDataEvent(const [49, 50], e))
    .toList();

void main(List<String> args) async {
  final hexoForm = HexoStateForm();
  late List<Future<GatewayControllerBLESensorDataEvent>> ble_sensor = [];
  late Stream<GatewayControllerBLESensorDataEvent> streamEmitor;
  for (var i = 0; i < mockData.length; i++) {
    ble_sensor.add(Future<GatewayControllerBLESensorDataEvent>.delayed(
        Duration(microseconds: i * 100), () => mockData[i]));
  }
  streamEmitor = Stream.fromFutures(ble_sensor);
  hexoForm.form.valueChanges.listen((event) {
    print(hexoForm.form.valid);
    print(event);
  });
  await for (var item in streamEmitor) {
    hexoForm.addBLEDataToForm(item);
  }
  print("Helloo");
}
