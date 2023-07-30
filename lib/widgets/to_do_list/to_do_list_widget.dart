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
    // return SingleChildScrollView(
    //   scrollDirection: Axis.vertical,
    //   child: Column(
    //     children: [
    //       for (int i = 0; i < widget.toDoList.tasks.length; i++)
    //         Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: TaskWidget(
    //             task: widget.toDoList.tasks[i],
    //             onDeleteTapped: () {
    //               setState(() {
    //                 widget.toDoList.tasks.removeAt(i);
    //               });
    //             },
    //           ),
    //         ),
    //     ],
    //   ),
    // );
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.toDoList.tasks.length,
      itemBuilder: (BuildContext context, int index) {
        return TaskWidget(
          task: widget.toDoList.tasks[index],
          onDeleteTapped: () {
            setState(() {
              widget.toDoList.tasks.removeAt(index);
            });
          },
        );
      },
    );
  }
}
