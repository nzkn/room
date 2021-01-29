import 'package:get_it/get_it.dart';
import 'package:room/core/services/push_notification_service.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<PushNotificationService>(() => PushNotificationService());
}
