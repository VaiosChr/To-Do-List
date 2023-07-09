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
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.toDoList.tasks.length,
      itemBuilder: (context, index) {
        return SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TaskWidget(task: widget.toDoList.tasks[index]),
              IconButton(
                icon: const Icon(Icons.delete_outline),
                color: alertColor,
                onPressed: () {
                  setState(() {
                    widget.toDoList.tasks.removeAt(index);
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
