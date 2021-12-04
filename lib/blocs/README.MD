#### ```[BLOC]```
##### ```[-> : meaning has a dependency]```

- Inner Bloc impl contain inner bloc dependency communication (bloc->bloc) as state subscriber and emit inner event.

- ```Folder/architecture``` refactor will be on fly when proof of concept (pseudo impl)

#### ```[Bluetooth Low Energy]```
- ble_repository [Provide RxBLE as highest dependency] (id:0)
```
-- ble_scan [Scanning for device_id] (id:1) ->(0)
    -- ble_device_connection [Connect to BLE (device)] (id:2) ->(0)
        -- ble_sensor (id:3) ->(2)
            [Application BLE sensor state abstraction, corresponding to 3(Proximity, Temp,..) ble_sensor_bloc] (1) ->(0)
        -- ble_sensor_controller [ble_sensor_bloc control when ble sensor singal valid, not out of time] (2)  (id:4)  ->x3(3),(2)
            Hexo state class use to mange and valid state, bloc only for emit state
```

#### ```[Application normal bloc]```
architectures still in working process heavy depend on backend impl
```
-- mqtt_bloc
-- setting_bloc
-- auth_bloc
```
