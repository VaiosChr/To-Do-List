import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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

  static Future<void> updateList(ToDoList toDoList) async {
    List<ToDoList> categories = [];
    categories = await loadCategories();

    ///@TODO: this saving logic almost works!!!
    for (int i = 0; i < categories.length; i++) {
      if (categories[i].key.toString() == toDoList.key.toString()) {
        categories[i].tasks = toDoList.tasks;
        saveCategories(categories);
        break;
      }
    }
  }
}