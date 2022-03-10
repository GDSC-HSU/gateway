import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateway/config/routes/router_name.dart';
import 'package:gateway/config/routes/routing.dart';
import 'package:gateway/screens/introduction_screen/introduction_screen.dart';

import 'di/di.dart';
import 'di/di_repository.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return AppRepositoryProvider(
      child: AppDependencyProvider(
        child: ScreenUtilInit(
          designSize: const Size(360, 640),
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
            debugShowCheckedModeBanner: false,
            initialRoute: AppRouting.introduction,
            onGenerateRoute: RouterName.generateRoute,
            home: const IntroductionScreen(),
          ),
        ),
      ),
    );
  }
}
