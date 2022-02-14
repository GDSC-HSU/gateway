import 'package:flutter/material.dart';
import 'package:gateway/di.dart';
import 'package:gateway/di_repository.dart';
import 'package:gateway/pages/test/test_page.dart';

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
