import 'package:flutter/cupertino.dart';

import 'package:to_do_list/widgets/to_do_list/to_do_list_widget.dart';

class MyNotifier extends ChangeNotifier {
  List<ToDoList> _categories = [];

  List<ToDoList> get categories => _categories;

  void updateCategories(List<ToDoList> newCategories) {
    _categories = newCategories;
    notifyListeners();
  }
}