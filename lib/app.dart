import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:room/core/router/router.gr.dart';
import 'package:room/localization/app_localizations.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Room',
      builder: ExtendedNavigator.builder<AppRouter>(
        router: AppRouter(),
        builder: (context, extendedNav) {
          return Theme(
            data: ThemeData(
              brightness: Brightness.dark,
              fontFamily: 'Effra',
            ),
            child: extendedNav,
          );
        }
      ),
      supportedLocales: [
        Locale('en', 'US'),
        Locale('uk', 'UA'),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      // ignore: missing_return
      localeResolutionCallback: (locale, supportedLocales) {
        for (var i = 0; i < supportedLocales.length; i ++) {
          if (supportedLocales.elementAt(i).languageCode == locale.languageCode &&
              supportedLocales.elementAt(i).countryCode == locale.countryCode) {
            return supportedLocales.elementAt(i);
          }
        }
        return supportedLocales.first;
      },
    );
  }
}
