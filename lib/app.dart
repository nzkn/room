import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:room/core/router/router.gr.dart';
import 'package:room/localization/app_localizations.dart';
import 'package:room/localization/locale_builder.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LocaleBuilder(
      builder: (context, locale) {
        return MaterialApp(
          title: 'Room',
          builder: ExtendedNavigator.builder<AppRouter>(
            router: AppRouter(),
            builder: (context, extendedNav) {
              return Theme(
                data: ThemeData(
                  brightness: Brightness.dark,
                  fontFamily: 'Montserrat',
                ),
                child: extendedNav,
              );
            },
          ),
          locale: locale,
          supportedLocales: [
            Locale('en', 'US'),
            Locale('uk', 'UA'),
          ],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
        );
      },
    );
  }
}
