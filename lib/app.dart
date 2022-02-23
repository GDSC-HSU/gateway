import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/screens/setup_screen/setup_screen.dart';
import 'package:gateway/screens/test/test_page.dart';

import 'di/di.dart';
import 'di/di_repository.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppRepositoryProvider(
        child: AppDependencyProvider(
      child: ScreenUtilInit(
        designSize: Size(360, 640),
        builder: () => MaterialApp(
          builder: (context, widget) {
            //add this line
            ScreenUtil.setContext(context);
            return MediaQuery(
              //Setting font does not change with system font size
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget!,
            );
          },
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'Flutter rxBLE',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SetupScreen(),
        ),
      ),
    ));
  }
}
