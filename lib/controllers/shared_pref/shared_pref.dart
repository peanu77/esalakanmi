import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPreferences _preferences =
      SharedPreferences.getInstance() as SharedPreferences;

  static const _keyUsername = 'username';
  static const _keyEmail = 'email';

  static Future setUsername(String username) async =>
      await _preferences.setString(_keyUsername, username);

  static String? getUsername() => _preferences.getString(_keyUsername);

  static Future setEmail(String email) async =>
      await _preferences.setString(_keyEmail, email);

  static String? getEmail() => _preferences.getString(_keyEmail);

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
}
