import 'dart:convert';
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';

import "./task.dart";
import "./preferences.dart";

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Preferences.init();
  runApp(MyApp());
}

//the main class of the app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "To-Do List",
      home: ToDoListView(),
    );
  }
}

//the to-do list widget class
class ToDoListView extends StatefulWidget {
  ToDoListView({Key? key}) : super(key: key);

  @override
  _ToDoListViewState createState() => _ToDoListViewState();
}

//the to-do list widget state class
class _ToDoListViewState extends State<ToDoListView> {
  //a list of tasks, which makes up the to-do list
  late List<Task> tasks;

  @override
  void initState() {
    tasks = [Task()];
    
    if(jsonDecode(Preferences.getTasksList()) != null) {
      var tasksJson = jsonDecode(Preferences.getTasksList()) as List;
      tasks = tasksJson.map((tasks) => Task.fromJson(tasks)).toList();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("To-Do List"),
            Spacer(),
            IconButton(
              icon: Icon(Icons.done),
              onPressed: () async {
                Fluttertoast.showToast(
                  msg: 'Saved',
                );
                await Preferences.setTasksList(jsonEncode(tasks));
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, i) {
          return TaskWidget(
            task: tasks[i],
            onDeleteTapped: () {
              setState(() {
                tasks.remove(tasks[i]);
              });
            },
            onCheckTapped: (value) {
              setState(() {
                tasks[i].done = value!;
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(Icons.add),
        onPressed: () {
          setState(() => tasks.add(Task()));
        },
      ),
    );
  }
}
