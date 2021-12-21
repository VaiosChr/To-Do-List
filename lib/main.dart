import "package:flutter/material.dart";

import "./preferences.dart";
import 'group/group_view.dart';
import 'to_do_list/to_do_list_view.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      // home: ToDoListView(),
      home: GroupView(
        toDoListGroup: [
          ToDoListView(
            name: "Check",
          ),
        ],
      ),
    );
  }
}
