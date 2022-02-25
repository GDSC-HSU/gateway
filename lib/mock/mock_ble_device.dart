import 'dart:typed_data';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

final DiscoveredDevice mock_esp32 = DiscoveredDevice(
    id: "xx-xx-xx-xxx-xxxx",
    name: "esp32-gateway",
    serviceData: {},
    manufacturerData: Uint8List.fromList([]),
    rssi: 12,
    serviceUuids: []);
