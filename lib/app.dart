import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/config/themes/gateway_color.dart';
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
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.lightBlue,
            dividerTheme: DividerThemeData(
                space: 50,
                thickness: 10,
                color: Colors.lightBlueAccent,
                indent: 10,
                endIndent: 10),
            //primaryColor: const Color(0xFF3967D6),
            //primaryColorLight: const Color(0xFFF9FAFC),
            // Define the default font family.
            //fontFamily: 'Georgia',

            // Define the default `TextTheme`. Use this to specify the default
            // text styling for headlines, titles, bodies of text, and more.
            // textTheme: const TextTheme(
            //   headline1: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            //   headline6: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            //   bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
            // ),
          ),
          home: SetupScreen(),
        ),
      ),
    ));
  }
}
