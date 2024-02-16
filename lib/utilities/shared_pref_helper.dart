import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  final SharedPreferences _prefs;

  SharedPrefHelper(this._prefs);

  Future<void> saveToken(String value) async {
    _prefs.setString('token', value);
  }

  String? readToken() => _prefs.getString('token');
}
