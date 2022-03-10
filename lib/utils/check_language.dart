import 'package:gateway/model/language.dart';

class CheckLanguage {
  static LanguageModel checkLanguage(String languageCode) {
    switch (languageCode) {
      case 'en':
        return LanguageModel(
          imagePath: 'assets/images/en_flag.png',
          longName: 'English',
          shortName: 'EN',
        );
      case 'vi':
        return LanguageModel(
          imagePath: 'assets/images/vn_flag.png',
          longName: 'Vietnamese',
          shortName: 'VI',
        );
      default:
        return LanguageModel(
          imagePath: 'assets/images/en_flag.png',
          longName: 'English',
          shortName: 'EN',
        );
    }
  }
}
