
import 'package:h2o_keeper/generated/l10n.dart';

enum LanguageItem {
  english,
  spanish,
  german,
  french,
  hindi,
  portuguese,
}

extension LanguageItemExt on LanguageItem {
  String get title {
    switch (this) {
      case LanguageItem.english:
      return S.current.en;
      case LanguageItem.spanish:
      return S.current.es;
      case LanguageItem.german:
      return S.current.de;
      case LanguageItem.french:
      return S.current.fr;
      case LanguageItem.hindi:
      return S.current.hi;
      case LanguageItem.portuguese:
      return S.current.pt;
    }
  }

  String get languageCode {
    switch (this) {
      case LanguageItem.english:
      return "en";
      case LanguageItem.spanish:
      return "es";
      case LanguageItem.german:
      return "de";
      case LanguageItem.french:
      return "fr";
      case LanguageItem.hindi:
      return "hi";
      case LanguageItem.portuguese:
      return "pt";
    }
  }
}