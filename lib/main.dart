import "package:flutter/material.dart";

import 'package:to_do_list/to_do_list/task.dart';
import "./preferences.dart";
import 'group/group_view.dart';
import 'to_do_list/to_do_list_widget.dart';

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
      // home: ToDoListWidget(
      //   toDoList: ToDoList()
      // ),
      home: GroupView(
        toDoListGroup: [
          ToDoList(
            name: "Check",
            tasks: [Task()],
          ),
        ],
      ),
    );
  }
}
