// ignore: import_of_legacy_library_into_null_safe
// import 'package:shared_preferences/shared_preferences.dart';

// class Preferences {
//   static SharedPreferences _preferences = SharedPreferences.getInstance() as SharedPreferences;
//   static String _tasksLengthKey = "tasksLength";

//   static Future init() async {
//     _preferences = await SharedPreferences.getInstance();
//   }

//   static Future setTasksLength(int tasksLength) async {
//     await _preferences.setInt(_tasksLengthKey, tasksLength);
//   }

//   static int getTasksLength() => _preferences.getInt(_tasksLengthKey);
// }