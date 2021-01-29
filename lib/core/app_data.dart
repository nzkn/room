import 'package:room/core/repositories/shared_prefs.dart';

class AppData {
  static AppData _instance;

  static Future<AppData> getInstance() async {
    if(_instance == null) {
      _instance = AppData._internal();
      await _instance._initialize();
    }
    return _instance;
  }

  bool _isFirstLaunch;

  AppData._internal();

  Future<void> _initialize() async {
    _isFirstLaunch = await SharedPrefs.isFirstLaunch();
  }

  bool get isFirstLaunch => _isFirstLaunch;

  Future<void> updateFirstLaunch(bool isFirstLaunch) {
    return SharedPrefs.setFirstLaunch(isFirstLaunch);
  }

  Future<void> removeUserData() async {
    await SharedPrefs.removeFirstLaunch();
  }
}