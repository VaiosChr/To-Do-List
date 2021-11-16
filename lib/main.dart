import "package:flutter/material.dart";

import "./preferences.dart";
import "./toDoListView.dart";

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Preferences.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "To-Do List",
      home: ToDoListView(),
    );
  }
}

