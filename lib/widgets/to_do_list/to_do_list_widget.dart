import "package:flutter/material.dart";

import '../../const/colors.dart';
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
}

class ToDoListWidget extends StatefulWidget {
  const ToDoListWidget({
    Key? key,
    required this.toDoList,
  }) : super(key: key);

  final ToDoList toDoList;

  @override
  State<ToDoListWidget> createState() => _ToDoListWidgetState();
}

class _ToDoListWidgetState extends State<ToDoListWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (int i = 0; i < widget.toDoList.tasks.length; i++) 
            TaskWidget(
              task: widget.toDoList.tasks[i],
              onDeleteTapped: () {
                setState(() {
                  widget.toDoList.tasks.removeAt(i);
                });
              },
            ),
        ],
      ),
    );
  }
}
