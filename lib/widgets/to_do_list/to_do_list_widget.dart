import 'dart:convert';
import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';

import '../../const/colors.dart';
import '../custom_widgets.dart';
import 'task.dart';

class ToDoList {
  //@TODO: set a unique ID for every toDoList object, for the saving logic
  String name;
  late List<Task> tasks;
  Color color;
  bool isTodays;

  ToDoList({
    this.name = "",
    required this.tasks,
    required this.color,
    this.isTodays = false,
  });

  Map toJson() {
    return {
      "name": name,
      "tasks": tasks,
      "isTodays": isTodays,
    };
  }

  void onColorChanged(Color newColor) {
    for (var task in tasks) {
      task.color = newColor;
    }
    color = newColor;
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
  void initState() {
    super.initState();
    loadTasks().then((tasks) {
      setState(() {
        widget.toDoList.tasks = tasks;
      });
    });
  }

  Future<void> saveTasks(List<Task> tasks) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> taskStrings = tasks.map((e) {
      return json.encode(e.toJson());
    }).toList();

    await prefs.setStringList('tasks', taskStrings);
  }

  Future<List<Task>> loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> taskStrings = prefs.getStringList('tasks') ?? [];

    List<Task> tasks = taskStrings.map((e) {
      Map<String, dynamic> taskMap = json.decode(e);
      return Task.fromJson(taskMap);
    }).toList();

    return tasks;
  }

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
                saveTasks(widget.toDoList.tasks);
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
              saveTasks(widget.toDoList.tasks);
            },
          ),
      ],
    );
    // return ListView.builder(
    //   shrinkWrap: true,
    //   itemCount: widget.toDoList.tasks.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     return TaskWidget(
    //       task: widget.toDoList.tasks[index],
    //       onDeleteTapped: () {
    //         setState(() {
    //           widget.toDoList.tasks.removeAt(index);
    //         });
    //       },
    //     );
    //   },
    // );
  }
}
