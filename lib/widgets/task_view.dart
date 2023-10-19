import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:to_do_list/const/colors.dart';
import 'package:to_do_list/widgets/to_do_list/task.dart';
import 'package:to_do_list/widgets/to_do_list/to_do_list_widget.dart';

class TodaysTasksView extends StatefulWidget {
  final ToDoList toDoList;

  const TodaysTasksView({
    required this.toDoList,
    super.key,
  });

  @override
  State<TodaysTasksView> createState() => _TodaysTasksViewState();
}

class _TodaysTasksViewState extends State<TodaysTasksView> {
  @override 
  void initState() {
    super.initState();
    loadTasks().then((value) {
      setState(() {
        widget.toDoList.tasks = value;
      });
    });
  }

  Future<List<Task>> loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> taskStrings = prefs.getStringList('tasks') ?? [];

    List<Task> loadedTasks = taskStrings.map((e) {
      Map<String, dynamic> taskMap = json.decode(e);
      return Task.fromJson(taskMap);
    }).toList();

    return loadedTasks;
  }

  Future<void> saveTasks(List<Task> tasks) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> taskStrings = tasks.map((e) {
      return json.encode(e.toJson());
    }).toList();

    await prefs.setStringList('tasks', taskStrings);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              "TODAY'S TASKS",
              style: TextStyle(
                color: greyTextColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(
                Icons.add,
                color: greyTextColor,
              ),
              onPressed: () {
                setState(() {
                  widget.toDoList.tasks.add(
                    Task(
                      color: widget.toDoList.color,
                    ),
                  );
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 15),
        ToDoListWidget(
          toDoList: ToDoList(
            tasks: widget.toDoList.tasks,
            color: widget.toDoList.color,
          ),
        ),
      ],
    );
  }
}
