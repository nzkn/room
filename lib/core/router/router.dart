import 'package:auto_route/auto_route_annotations.dart';
import 'package:room/modules/auth/language_screen.dart';
import 'package:room/modules/auth/log_in_screen.dart';
import 'package:room/modules/auth/reset_password_screen.dart';
import 'package:room/modules/auth/sign_up_screen.dart';
import 'package:room/modules/chat/chat_screen.dart';
import 'package:room/modules/onboarding/onboarding_screen.dart';
import 'package:room/modules/settings/settings_screen.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: OnBoardingScreen),
    MaterialRoute(page: LanguageScreen, initial: true),
    MaterialRoute(page: SignUpScreen),
    MaterialRoute(page: LogInScreen),
    MaterialRoute(page: ResetPasswordScreen),
    MaterialRoute(page: ChatScreen),
    MaterialRoute(page: SettingsScreen),
  ],
)
class $AppRouter {}