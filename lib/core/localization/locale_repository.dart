import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleRepository {
  final _streamController = StreamController<String>.broadcast();
  LocaleRepository._internal();
  LocalStorage _storage;
  String _locale;

  Stream<String> observeLocale() {
    loadLocale()
        .then((v) => _streamController.add(v))
        .catchError((e) => _streamController.addError(e));
    return _streamController.stream;
  }

  Future<String> loadLocale() async {
    final storage = _storage ?? await LocalStorage.getStorage();
    _locale = _locale ?? storage.read('locale');
    return _locale;
  }

  Future<void> saveLocale(String languageCode) async {
    final storage = _storage ?? await LocalStorage.getStorage();
    await storage.write('locale', languageCode);
    _locale = languageCode;
    _streamController.add(_locale);
  }

  static final LocaleRepository _singleton = LocaleRepository._internal();
  static  LocaleRepository getInstance() => _singleton;
}


class LocalStorage {

  final SharedPreferences _prefs;

  LocalStorage(SharedPreferences prefs) : _prefs = prefs;

  Future<bool> write(String key, String value) {
    return _prefs.setString(key, value);
  }

  String read(String key) {
    return _prefs.getString(key);
  }

  static Future<LocalStorage> getStorage() async {
    return LocalStorage(await SharedPreferences.getInstance());
  }
}