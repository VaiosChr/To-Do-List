import "package:flutter/material.dart";

import 'package:to_do_list/preferences.dart';
import 'package:to_do_list/widgets/custom_widgets.dart';
import 'package:to_do_list/widgets/to_do_list/task.dart';

class ToDoList {
  String name;
  late List<Task> tasks;
  Color color;
  bool isTodays;
  final String key;

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
      key: json["key"],
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
            GreyText(
              text: widget.toDoList.isTodays ? "TODAY'S TASKS" : "TASKS",
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
                if (widget.toDoList.isTodays) {
                  SharedPreferencesService.saveTodaysTasks(widget.toDoList);
                } else {
                  SharedPreferencesService.updateList(widget.toDoList);
                }
              },
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          // physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.toDoList.tasks.length,
          itemBuilder: (context, index) {
            return TaskWidget(
              task: widget.toDoList.tasks[index],
              onDeleteTapped: () {
                setState(() {
                  widget.toDoList.tasks.removeAt(index);
                });
                if (widget.toDoList.isTodays) {
                  SharedPreferencesService.saveTodaysTasks(widget.toDoList);
                } else {
                  SharedPreferencesService.updateList(widget.toDoList);
                }
              },
              onChanged: () {
                if (widget.toDoList.isTodays) {
                  SharedPreferencesService.saveTodaysTasks(widget.toDoList);
                } else {
                  SharedPreferencesService.updateList(widget.toDoList);
                }
              },
            );
          },
        ),
      ],
    );
  }
}
