import "package:flutter/material.dart";

import 'package:to_do_list/const/colors.dart';
import 'package:to_do_list/preferences.dart';
import 'package:to_do_list/widgets/custom_widgets.dart';
import 'package:to_do_list/widgets/to_do_list/task.dart';

class ToDoList {
  //@TODO: set a unique ID for every toDoList object, for the saving logic
  String name;
  late List<Task> tasks;
  Color color;
  bool isTodays;
  final Key key;

  ToDoList({
    this.name = "",
    required this.tasks,
    required this.color,
    required this.key,
    this.isTodays = false,
  });

  Map toJson() {
    return {
      "name": name,
      "tasks": tasks.map((task) => task.toJson()).toList(),
      "isTodays": isTodays,
      "color": color.value.toRadixString(16),
      "key": key.toString(),
    };
  }

  factory ToDoList.fromJson(Map<String, dynamic> json) {
    return ToDoList(
      name: json["name"],
      tasks:
          (json['tasks'] as List).map((task) => Task.fromJson(task)).toList(),
      color: Color(int.parse(json["color"], radix: 16)),
      key: Key(json["key"]),
      isTodays: json["isTodays"],
    );
  }

  // utilities
  void onColorChanged(Color newColor) {
    for (var task in tasks) {
      task.color = newColor;
    }
    color = newColor;
  }

  int getCompletedTasks() {
    int completedTasks = 0;

    for (var task in tasks) {
      if (task.done) {
        completedTasks++;
      }
    }
    return completedTasks;
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
    return Column(
      children: [
        Row(
          children: [
            Text(
              widget.toDoList.isTodays ? "TODAY'S TASKS" : "TASKS",
              style: const TextStyle(
                color: greyTextColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
            const Spacer(),
            AddButton(
              onPressed: () {
                setState(
                  () => widget.toDoList.tasks.add(
                    Task(
                      color: widget.toDoList.color,
                    ),
                  ),
                );
                SharedPreferencesService.updateList(widget.toDoList);
              },
            ),
          ],
        ),
        for (int i = 0; i < widget.toDoList.tasks.length; i++)
          TaskWidget(
            task: widget.toDoList.tasks[i],
            onDeleteTapped: () {
              setState(() => widget.toDoList.tasks.removeAt(i));
            },
            onChanged: () {
              SharedPreferencesService.updateList(widget.toDoList);
            },
          ),
      ],
    );
  }
}
