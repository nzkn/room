import 'package:flutter/material.dart';

class AppLocalization {
  final Map<String, dynamic> localizedValues;
  final Locale locale;
  final Map<String, dynamic> countries;

  AppLocalization(this.locale, this.localizedValues, this.countries);

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  String get english => localizedValues[locale.languageCode]['english'];
  String get ukrainian => localizedValues[locale.languageCode]['ukrainian'];
  String get continueStr => localizedValues[locale.languageCode]['continueStr'];
}