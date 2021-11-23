import 'package:shared_preferences/shared_preferences.dart';

enum PrefKeys { lang }

class SharedPrefController {
  static final SharedPrefController _instance =
      SharedPrefController._internal();
  late SharedPreferences _sharedPreferences;

  SharedPrefController._internal();

  factory SharedPrefController() {
    return _instance;
  }

  Future<void> initPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> setLanguage({required String lang}) async {
    await _sharedPreferences.setString(PrefKeys.lang.toString(), lang);
  }

  String get language => _sharedPreferences.getString(PrefKeys.lang.toString()) ?? 'en';
}
