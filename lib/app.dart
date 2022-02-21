import 'package:easy_localization/easy_localization.dart';
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
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'Flutter rxBLE',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TestPage(),
      ),
    ));
  }
}
