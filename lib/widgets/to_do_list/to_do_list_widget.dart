import "package:flutter/material.dart";

import 'task.dart';

class ToDoList {
  String name;
  late List<Task> tasks;
  Color color;

  ToDoList({
    this.name = "",
    required this.tasks,
    required this.color,
  });

  Map toJson() {
    return {
      "name": name,
      "tasks": tasks,
    };
  }

  // factory ToDoList.fromJson(Map<String, dynamic> json) {
  //   var list = json["tasks"] as List;
  //   List<Task> tasksList = list.map((i) => Task.fromJson(i)).toList();

  //   return ToDoList(
  //     name: json["name"] as String,
  //     tasks: tasksList,
  //   );
  // }

  // @override
  // String toString() {
  //   return "{$name, $tasks}";
  // }
}

class ToDoListWidget extends StatelessWidget {
  const ToDoListWidget({
    Key? key,
    required this.toDoList,
  }) : super(key: key);

  final ToDoList toDoList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: toDoList.tasks.length,
      itemBuilder: (context, index) {
        return TaskWidget(task: toDoList.tasks[index]);
      },
    );
  }
}
