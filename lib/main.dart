import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:gateway/business_logic/ble/ble_connector/bloc/ble_connector_bloc.dart';
import 'package:gateway/di.dart';
import 'package:gateway/pages/test/test_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterReactiveBle().initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FlutterReactiveBle rxble = FlutterReactiveBle();
  MyApp({
    Key? key,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProvideDependency(
      child: MaterialApp(
        title: 'Flutter rxBLE',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TestPage(),
      ),
    );
  }
}
