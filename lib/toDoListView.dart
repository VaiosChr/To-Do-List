import "package:flutter/material.dart";
import "dart:convert";
import 'package:fluttertoast/fluttertoast.dart';

import "./task.dart";
import "./preferences.dart";

class ToDoListView extends StatefulWidget {
  ToDoListView({Key? key}) : super(key: key);

  @override
  _ToDoListViewState createState() => _ToDoListViewState();
}

class _ToDoListViewState extends State<ToDoListView> {
  late List<Task> tasks;

  @override 
  void initState() {
    if(Preferences.getTasksList() == "") {
      tasks = [Task()];
    } else {
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
