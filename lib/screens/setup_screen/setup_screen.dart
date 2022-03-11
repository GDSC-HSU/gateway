import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:gateway/config/themes/gateway_color.dart';
import 'package:gateway/generated/locale_keys.g.dart';
import 'package:gateway/model/language.dart';
import 'package:gateway/screens/setup_screen/setup_view.dart';
import 'package:gateway/utils/check_language.dart';
import 'package:gateway/widgets/common/build_appbar.dart';

class SetupScreen extends StatefulWidget {
  SetupScreen({Key? key}) : super(key: key);

  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    LanguageModel languageModel =
        CheckLanguage.checkLanguage(context.locale.languageCode);
    return Scaffold(
      backgroundColor: GatewayColors.scaffoldBgLight,
      appBar: BuildAppBar(
        languageModel: languageModel, title: LocaleKeys.setup_title.tr(), leading: Container(),
        //"Setup Gateway",
      ),
      body: SetupView(),
    );
  }
}
