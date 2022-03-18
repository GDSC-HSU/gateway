import 'package:gateway/blocs/ble_sensor/ble_sensor.dart';
import 'package:gateway/blocs/ble_sensor_controller/bloc/ble_sensor_controller_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

enum FromType { proximity, temperature, rfid, radar, faceCamera, maskCamera }

class HexoStateForm {
  late FormGroup form = FormGroup(_createFormControlForBLEData());

  FormControl getBLEFormControl(SensorType type) {
    return form.controls[type.toString()] as FormControl;
  }

  static Map<String, FormControl> _createFormControlForBLEData() {
    // final bleSensorForm = SensorType.values.asNameMap().map((key, value) =>
    //     MapEntry(value.name, FormControl(validators: [Validators.required])));
    return {SensorType.proximity.toString(): FormControl()};
  }

  addBLEDataToForm(BleSensorControllerSensorDataEvent event) {
    final data = bleFromData(event);
    final formControl = getBLEFormControl(event.sensorType);
    formControl.value = data;
    formControl.markAsTouched();
  }

  addHardWareSensorToForm() {}

  String bleFromData(BleSensorControllerSensorDataEvent event) {
    // parsing by data
    return String.fromCharCodes(
      event.data,
    );
  }

  clearForm() {
    form.reset();
  }

  get formValue => form.value;

  Stream<ControlStatus> get controlStatusStream => form.statusChanged;
}

var mockData = SensorType.values
    .map((e) => BleSensorControllerSensorDataEvent(const [49, 50], e))
    .toList();

void main(List<String> args) async {
  final hexoForm = HexoStateForm();
  late List<Future<BleSensorControllerSensorDataEvent>> ble_sensor = [];
  late Stream<BleSensorControllerSensorDataEvent> streamEmitor;
  for (var i = 0; i < mockData.length; i++) {
    ble_sensor.add(Future<BleSensorControllerSensorDataEvent>.delayed(
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
