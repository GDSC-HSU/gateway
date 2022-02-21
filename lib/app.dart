import 'package:flutter/material.dart';
import 'package:gateway/screens/test/test_page.dart';

import 'di/di.dart';
import 'di/di_repository.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppRepositoryProvider(
        child: AppDependencyProvider(
      child: MaterialApp(
        title: 'Flutter rxBLE',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TestPage(),
      ),
    ));
  }
}
