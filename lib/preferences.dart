import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/const/colors.dart';

import 'package:to_do_list/widgets/to_do_list/to_do_list_widget.dart';

class SharedPreferencesService {
  static Future<void> saveCategories(List<ToDoList> categories) async {
    final prefs = await SharedPreferences.getInstance();
    final categoriesJson =
        categories.map((toDoList) => toDoList.toJson()).toList();
    await prefs.setString('categories', jsonEncode(categoriesJson));
  }

  static Future<List<ToDoList>> loadCategories() async {
    final prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    final categoriesJson = prefs.getString('categories');
    if (categoriesJson != null) {
      final List<dynamic> categoriesList = jsonDecode(categoriesJson);
      return categoriesList
          .map((toDoList) => ToDoList.fromJson(toDoList))
          .toList();
    }

    return [];
  }

  static Future<void> saveTodaysTasks(ToDoList toDoList) async {
    final prefs = await SharedPreferences.getInstance();
    final todaysTasksJson = toDoList.toJson();
    await prefs.setString('todaysTasks', jsonEncode(todaysTasksJson));
  }

  static Future<ToDoList> loadTodaysTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final todaysTasksJson = prefs.getString('todaysTasks');
    if (todaysTasksJson != null) {
      final todaysTasks = jsonDecode(todaysTasksJson);
      return ToDoList.fromJson(todaysTasks);
    }

    return ToDoList(
      name: 'Today\'s Tasks',
      color: greyTextColor,
      tasks: [],
      key: UniqueKey().toString(),
      isTodays: true,
    );
  }

  static Future<void> updateList(ToDoList toDoList) async {
    List<ToDoList> categories = [];
    categories = await loadCategories();

    for (int i = 0; i < categories.length; i++) {
      if (categories[i].key == toDoList.key) {
        if (toDoList.name == "") {
          toDoList.name = categories[i].name;
        }
        categories[i] = toDoList;
        saveCategories(categories);
        break;
      }
    }
  }
}
