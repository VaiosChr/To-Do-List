import "package:flutter/material.dart";

import 'package:to_do_list/to_do_list/task.dart';
import "./preferences.dart";
import 'group/group_view.dart';
import 'to_do_list/to_do_list_widget.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Preferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "To-Do List",
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      // home: ToDoListWidget(
      //   toDoList: ToDoList()
      // ),
      initialRoute: "/group",
      routes: {
        "/list": (context) => ToDoListWidget(
              toDoList: ToDoList(
                tasks: [],
              ),
            ),
        "/group": (context) => GroupView(
              group: [],
            ),
      },
      home: GroupView(
        group: [
          ToDoList(
            name: "Check",
            tasks: [Task()],
          ),
        ],
      ),
    );
  }
}
