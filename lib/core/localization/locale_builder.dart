import 'package:flutter/material.dart';
import 'package:room/core/localization/locale_repository.dart';

class LocaleBuilder extends StatelessWidget {

  final Function(BuildContext, Locale) builder;

  const LocaleBuilder({Key key, this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: LocaleRepository.getInstance().observeLocale(),
      builder: (context, snapshot) {
        return builder(context, Locale(snapshot.data ?? _getLanguage()));
      },
    );
  }

  String _getLanguage() {
    List<String> deviceLocales = WidgetsBinding.instance.window.locales
        .map((loc) => loc.languageCode)
        .toList();

    if (deviceLocales.isNotEmpty) {
      if (deviceLocales.first == 'ua') {
        return 'ua';
      } else {
        return 'en';
      }
    } else {
      return 'ua';
    }
  }
}