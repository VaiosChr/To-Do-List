import 'package:flutter/material.dart';

import 'package:to_do_list/const/colors.dart';
import 'package:to_do_list/widgets/to_do_list/task.dart';
import 'package:to_do_list/widgets/to_do_list/to_do_list_widget.dart';

class TodaysTasksView extends StatefulWidget {
  const TodaysTasksView({super.key});

  @override
  State<TodaysTasksView> createState() => _TodaysTasksViewState();
}

class _TodaysTasksViewState extends State<TodaysTasksView> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
        const SizedBox(height: 15),
        ToDoListWidget(
          toDoList: ToDoList(
            tasks: [Task()],
          ),
        ),
      ],
    );
  }
}
