import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:room/core/router/route_names.dart';
import 'package:room/localization/app_localizations.dart';
import 'package:room/localization/locale_builder.dart';
import 'package:room/modules/auth/log_in_screen.dart';
import 'package:room/modules/auth/reset_password_screen.dart';
import 'package:room/modules/auth/sign_up_method_screen.dart';
import 'package:room/modules/auth/sign_up_screen.dart';
import 'package:room/modules/main/main_screen.dart';
import 'package:room/modules/onboarding/onboarding_screen.dart';
import 'package:room/modules/auth/language_screen.dart';

import 'core/app_data.dart';
import 'modules/settings/language_screen.dart';

class App extends StatelessWidget {
  final AppData appData;

  const App(this.appData);

  @override
  Widget build(BuildContext context) {
    String initialRoute = RouteNames.languageScreen;

    if (appData.isFirstLaunch) {
      initialRoute = RouteNames.onboardingRoute;
      appData.updateFirstLaunch(false);
    }

    return LocaleBuilder(
      builder: (context, locale) {
        return MaterialApp(
          title: 'Room',
          theme: ThemeData(
            brightness: Brightness.dark,
            fontFamily: 'Montserrat',
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
          onGenerateRoute: onGenerateRoute,
          initialRoute: initialRoute,
        );
      },
    );
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    Widget page;

    switch (settings.name)  {
      case RouteNames.languageScreen:
        page = LanguageScreen();
        break;
      case RouteNames.signUpMethodScreen:
        page = SignUpMethodScreen();
        break;
      case RouteNames.onboardingRoute:
        page = OnBoardingScreen();
        break;
      case RouteNames.logInRoute:
        page = LogInScreen();
        break;
      case RouteNames.signUpRoute:
        page = SignUpScreen();
        break;
      case RouteNames.resetPasswordRoute:
        page = ResetPasswordScreen();
        break;
      case RouteNames.mainRoute:
        page = MainScreen();
        break;
      case RouteNames.languageSettingsRoute:
        page = LanguageSettingScreen();
        break;
    }

    return MaterialPageRoute(builder: (context) => page, settings: settings);
  }
}
