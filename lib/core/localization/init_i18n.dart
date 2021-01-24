import 'dart:async' show Future;
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

final List<String> languages = ["en", "ua"];

Map<String, String> _convertValueToString(obj) {
  Map<String, String> result = {};
  obj.forEach((key, value) {
    result[key] = value.toString();
  });
  return result;
}

Future<Map<String, Map<String, String>>> initializeI18n() async {
  Map<String, Map<String, String>> values = {};
  for (var i = 0; i < languages.length; i++) {
    Map<String, dynamic> translation = await json.decode(await rootBundle.loadString('assets/i18n/' + languages[i] + '.json'));
    values[languages[i]] = _convertValueToString(translation);
  }
  return values;
}

Future<Map<String, String>> getCountries() async {
  Map<String, dynamic> countries = await json.decode(await rootBundle.loadString('assets/i18n/countries/countries.json'));
  return _convertValueToString(countries);
}
