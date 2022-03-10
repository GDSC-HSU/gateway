class LanguageModel {
  final String longName;
  final String shortName;
  final String imagePath;

  LanguageModel({
    required this.longName,
    required this.shortName,
    required this.imagePath,
  });
}


enum TypeLanguage{
  en,
  vi,
}
