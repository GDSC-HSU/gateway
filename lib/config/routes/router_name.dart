import 'package:flutter/material.dart';
import 'package:flutter_study_jam/page/dictionary/dictionary_page.dart';
import 'package:flutter_study_jam/page/user/login_page.dart';
import 'package:flutter_study_jam/page/user/register_page.dart';

class RouterName {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'LoginPage':
        return MaterialPageRoute(builder: (context) => LoginPage());
      case 'RegisterPage':
        return MaterialPageRoute(builder: (context) => RegisterPage());
      case 'DictionaryPage':
        return MaterialPageRoute(builder: (context) => DictionaryPage());
      default:
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            );
          },
        );
    }
  }
}
