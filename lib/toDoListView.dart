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
  String name = "";
  late List<Task> tasks;

  @override
  void initState() {
    //initialize the tasks from the encoded json list
    if (Preferences.getTasksList() == "") {
      tasks = [Task()];
    } else {
      var tasksJson = jsonDecode(Preferences.getTasksList()) as List;
      tasks = tasksJson.map((tasks) => Task.fromJson(tasks)).toList();
    }

    //delete all the empty tasks
    for(int i = 0; i < tasks.length; i++) {
      if(!tasks[i].done && tasks[i].title == "") tasks.remove(tasks[i]);
    }

    //initialize the name of the to-do list
    name = Preferences.getListName();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _textEditingController = TextEditingController(text: name);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "To-Do List Name",
          ),
          onChanged: (text) async {
            name = text;
            await Preferences.setListName(name);
          },
          controller: _textEditingController,
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
            onTitleChanged: () async {
              await Preferences.setTasksList(jsonEncode(tasks));
            }
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
