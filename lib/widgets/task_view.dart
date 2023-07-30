import 'package:flutter/material.dart';

import 'package:to_do_list/const/colors.dart';
import 'package:to_do_list/widgets/to_do_list/task.dart';
import 'package:to_do_list/widgets/to_do_list/to_do_list_widget.dart';
import 'category.dart';

class TodaysTasksView extends StatefulWidget {
  final Category category;

  const TodaysTasksView({
    required this.category,
    super.key,
  });

  @override
  State<TodaysTasksView> createState() => _TodaysTasksViewState();
}

class _TodaysTasksViewState extends State<TodaysTasksView> {
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
                  widget.category.tasks.add(
                    Task(
                      color: widget.category.color,
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
            tasks: widget.category.tasks,
            color: widget.category.color,
          ),
        ),
      ],
    );
  }
}
