import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:room/core/router/router.gr.dart';


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Room',
      builder: ExtendedNavigator.builder<AppRouter>(
        router: AppRouter(),
        builder: (context, extendedNav) => Theme(
          data: ThemeData(
            brightness: Brightness.dark,
            fontFamily: 'Effra',
          ),
          child: extendedNav,
        ),
      ),
    );
    // return LocaleBuilder(
    //   builder: (context, locale) {
    //     return MaterialApp(
    //       title: 'Room',
    //       builder: ExtendedNavigator.builder<AppRouter>(
    //         router: AppRouter(),
    //         builder: (context, extendedNav) => Theme(
    //           data: ThemeData(
    //             brightness: Brightness.dark,
    //             fontFamily: 'Effra',
    //           ),
    //           child: extendedNav,
    //         ),
    //       ),
    //       supportedLocales: languages.map((lang) => Locale(lang, '')).toList(),
    //       locale: locale,
    //       localizationsDelegates: [
    //         AppLocalizationsDelegate(),
    //         GlobalMaterialLocalizations.delegate,
    //         GlobalWidgetsLocalizations.delegate,
    //         GlobalCupertinoLocalizations.delegate,
    //       ],
    //     );
    //   },
    // );
  }
}
