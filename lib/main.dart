import "package:flutter/material.dart";
import 'package:to_do_list/pages/home_page.dart';

import 'package:to_do_list/widgets/to_do_list/task.dart';
import "./preferences.dart";
import 'widgets/group/group_view.dart';
import 'widgets/to_do_list/to_do_list_widget.dart';

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
        primaryColor: const Color.fromARGB(255, 194, 109, 233),
        primarySwatch: Colors.indigo,
      ),
      home: HomePage(),
      // home: ToDoListWidget(
      //   toDoList: ToDoList(
      //     tasks: [Task()],
      //   ),
      // ),
      // initialRoute: "/group",
      // routes: {
      //   "/list": (context) => ToDoListWidget(
      //         toDoList: ToDoList(
      //           tasks: [],
      //         ),
      //       ),
      //   "/group": (context) => GroupView(
      //         group: [],
      //       ),
      // },
      // home: GroupView(
      //   group: [
      //     ToDoList(
      //       name: "Check",
      //       tasks: [Task()],
      //     ),
      //   ],
      // ),
    );
  }
}