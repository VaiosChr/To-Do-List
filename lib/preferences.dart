// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences _preferences =
      SharedPreferences.getInstance() as SharedPreferences;
  static const tasksKey = "tasks";

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setTasksList(String tasks) async =>
      await _preferences.setString(tasksKey, tasks);

      static String getTasksList() => _preferences.getString(tasksKey);
}
