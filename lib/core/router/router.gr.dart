// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:room/modules/main/main_screen.dart';
import 'package:room/modules/settings/language_screen.dart';

import '../../modules/auth/language_screen.dart';
import '../../modules/auth/log_in_screen.dart';
import '../../modules/auth/reset_password_screen.dart';
import '../../modules/auth/sign_up_screen.dart';
import '../../modules/chat/chat_screen.dart';
import '../../modules/onboarding/onboarding_screen.dart';
import '../../modules/settings/settings_screen.dart';

class Routes {
  static const String onBoardingScreen = '/';
  static const String languageScreen = '/language-screen';
  static const String signUpScreen = '/sign-up-screen';
  static const String logInScreen = '/log-in-screen';
  static const String resetPasswordScreen = '/reset-password-screen';
  static const String mainScreen = '/main-screen';
  static const String chatScreen = '/chat-screen';
  static const String settingsScreen = '/settings-screen';
  static const String changeLanguageScreen = '/change-language-screen';
  static const all = <String>{
    onBoardingScreen,
    languageScreen,
    signUpScreen,
    logInScreen,
    resetPasswordScreen,
    mainScreen,
    chatScreen,
    settingsScreen,
    changeLanguageScreen,
  };
}

class AppRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.onBoardingScreen, page: OnBoardingScreen),
    RouteDef(Routes.languageScreen, page: LanguageScreen),
    RouteDef(Routes.signUpScreen, page: SignUpScreen),
    RouteDef(Routes.logInScreen, page: LogInScreen),
    RouteDef(Routes.resetPasswordScreen, page: ResetPasswordScreen),
    RouteDef(Routes.mainScreen, page: MainScreen),
    RouteDef(Routes.chatScreen, page: ChatScreen),
    RouteDef(Routes.settingsScreen, page: SettingsScreen),
    RouteDef(Routes.changeLanguageScreen, page: ChangeLanguageScreen),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    OnBoardingScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => OnBoardingScreen(),
        settings: data,
      );
    },
    LanguageScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LanguageScreen(),
        settings: data,
      );
    },
    SignUpScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignUpScreen(),
        settings: data,
      );
    },
    LogInScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LogInScreen(),
        settings: data,
      );
    },
    ResetPasswordScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ResetPasswordScreen(),
        settings: data,
      );
    },
    MainScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => MainScreen(),
        settings: data,
      );
    },
    ChatScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ChatScreen(),
        settings: data,
      );
    },
    SettingsScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SettingsScreen(),
        settings: data,
      );
    },
    ChangeLanguageScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ChangeLanguageScreen(),
        settings: data,
      );
    },
  };
}
