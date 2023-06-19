import 'dart:convert';

import 'package:egrocer/helper/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalization {
  late Locale locale;
  static Map<dynamic, dynamic> _localizedValues = {};

  AppLocalization(this.locale) {
    _localizedValues = {};
  }

  static AppLocalization? of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  String getTranslatedValues(String key) {
    if (_localizedValues.containsKey(key)) {
      return _localizedValues[key];
    } else {
      return key;
    }
  }

  static Future<AppLocalization> load(Locale locale) async {
    AppLocalization translations = AppLocalization(locale);
    String jsonContent = await rootBundle.loadString(
      Constant.getAssetsPath(2, locale.languageCode),
    );
    _localizedValues = json.decode(jsonContent);
    return translations;
  }

  get currentLanguage => locale.languageCode;
}

class TranslationsDelegate extends LocalizationsDelegate<AppLocalization> {
  const TranslationsDelegate();

  @override
  bool isSupported(Locale locale) => Constant.supportedLanguages.contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) => AppLocalization.load(locale);

  @override
  bool shouldReload(TranslationsDelegate old) => false;
}
