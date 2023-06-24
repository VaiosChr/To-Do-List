import "package:flutter/material.dart";
// import "dart:convert";

import 'task.dart';
// import 'package:to_do_list/preferences.dart';

class ToDoList {
  String name;
  late List<Task> tasks;

  ToDoList({
    this.name = "",
    required this.tasks,
  });

  Map toJson() {
    return {
      "name": name,
      "tasks": tasks,
    };
  }

  factory ToDoList.fromJson(Map<String, dynamic> json) {
    var list = json["tasks"] as List;
    List<Task> tasksList = list.map((i) => Task.fromJson(i)).toList();

    return ToDoList(
      name: json["name"] as String,
      tasks: tasksList,
    );
  }

  @override
  String toString() {
    return "{$name, $tasks}";
  }
}

class ToDoListWidget extends StatelessWidget {
  const ToDoListWidget({
    Key? key,
    required this.toDoList,
  }) : super(key: key);

  final ToDoList toDoList;

  @override
  Widget build(BuildContext context) {
    return TaskWidget(task: Task(title: "Test", done: true));
  }
}
