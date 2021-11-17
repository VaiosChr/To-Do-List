// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences _preferences =
      SharedPreferences.getInstance() as SharedPreferences;
  static const tasksKey = "tasks";
  static const listNameKey = "listName";

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setTasksList(String tasks) async {
    await _preferences.setString(tasksKey, tasks);
  }

  static String getTasksList() {
    return _preferences.getString(tasksKey) ?? "";
  }

  static Future setListName(String name) async {
    await _preferences.setString(listNameKey, name);
  }

  static String getListName() {
    return _preferences.getString(listNameKey) ?? "";
  }
}
