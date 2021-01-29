
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesServices{
  static SharedPreferencesServices _instance = SharedPreferencesServices._init();

  SharedPreferences _preferences;
  static SharedPreferencesServices get instance => _instance;

  SharedPreferencesServices._init() {
    SharedPreferences.getInstance().then((value) {
      _preferences = value;
    });
  }

  static prefrencesInit() async {
    if (instance._preferences == null) {
      instance._preferences = await SharedPreferences.getInstance();
    }
    return;
  }

  Future<void> setStringValue(String key, String value) async {
    await _preferences.setString(key.toString(), value);
  }

  String getStringValue(String key) =>
      _preferences.getString(key.toString()) ?? "";
}