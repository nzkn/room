import 'dart:async' show Future;
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/material.dart';
import 'package:room/core/localization/init_i18n.dart';
import 'package:room/core/localization/localization.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalization> {

  @override
  bool isSupported(Locale locale) => languages.contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) async {
    Map<String, Map<String, String>> localizedValues = await initializeI18n();
    Map<String, String> countries = await getCountries();
    return SynchronousFuture<AppLocalization>(
        AppLocalization(locale, localizedValues, countries));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}