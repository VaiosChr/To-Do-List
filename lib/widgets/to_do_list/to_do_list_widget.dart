import "package:flutter/material.dart";
import "dart:convert";

import 'task.dart';

import '../../preferences.dart';

class ToDoList {
  String name;
  late List<Task> tasks;

  ToDoList({
    this.name = "",
    required this.tasks,
  });

  Map toJson() {
    return {
      "name": name,
      "tasks": tasks,
    };
  }

  factory ToDoList.fromJson(Map<String, dynamic> json) {
    var list = json["tasks"] as List;
    List<Task> tasksList = list.map((i) => Task.fromJson(i)).toList();

    // return ToDoList(name: json["name"] as String, tasks: json["tasks"] as List<Task>);
    return ToDoList(
      name: json["name"] as String,
      tasks: tasksList,
    );
  }

  @override
  String toString() {
    return "{$name, $tasks}";
  }
}

// class ToDoListWidget extends StatefulWidget {
//   const ToDoListWidget({
//     Key? key,
//     required this.toDoList,
//   }) : super(key: key);

//   final ToDoList toDoList;

//   @override
//   _ToDoListWidgetState createState() => _ToDoListWidgetState();
// }

// class _ToDoListWidgetState extends State<ToDoListWidget> {
//   @override
//   void initState() {
//     // initialize the name of the to-do list
//     widget.toDoList.name = Preferences.getListName();

//     // initialize the tasks from the encoded json list
//     if (Preferences.getTasksList() == "" || widget.toDoList.tasks.isEmpty) {
//       widget.toDoList.tasks = [Task()];
//     } else {
//       var tasksJson = jsonDecode(Preferences.getTasksList()) as List;
//       widget.toDoList.tasks =
//           tasksJson.map((tasks) => Task.fromJson(tasks)).toList();

//       // delete all the empty tasks
//       for (int i = 0; i < widget.toDoList.tasks.length; i++) {
//         if (!widget.toDoList.tasks[i].done &&
//             widget.toDoList.tasks[i].title == "") {
//           widget.toDoList.tasks.remove(widget.toDoList.tasks[i]);
//         }
//       }
//     }

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController textEditingController =
//         TextEditingController(text: widget.toDoList.name);

//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           Container(
//             margin: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               color: Colors.grey[300],
//             ),
//             child: IconButton(
//               icon: const Icon(Icons.add),
//               color: Theme.of(context).primaryColor,
//               onPressed: () {
//                 setState(() {
//                   // add a new task
//                   widget.toDoList.tasks.add(Task());
//                 });
//               },
//             ),
//           ),
//         ],
//         title: TextField(
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//           decoration: const InputDecoration(
//             border: InputBorder.none,
//             hintText: "To-do list name...",
//             hintStyle: TextStyle(
//               color: Colors.white54,
//             ),
//           ),
//           onChanged: (text) async {
//             widget.toDoList.name = text;
//             await Preferences.setListName(text);
//           },
//           controller: textEditingController,
//         ),
//       ),
//       body: ListView.builder(
//         itemCount: widget.toDoList.tasks.length,
//         itemBuilder: (context, i) {
//           return TaskWidget(
//             task: widget.toDoList.tasks[i],
//             onDeleteTapped: () {
//               setState(() {
//                 widget.toDoList.tasks.remove(widget.toDoList.tasks[i]);
//               });
//             },
//             onCheckTapped: (value) async {
//               setState(() {
//                 widget.toDoList.tasks[i].done = value!;
//               });
//               await Preferences.setTasksList(jsonEncode(widget.toDoList.tasks));
//             },
//             onTitleChanged: () async {
//               await Preferences.setTasksList(jsonEncode(widget.toDoList.tasks));
//             },
//           );
//         },
//       ),
//     );
//   }
// }

class ToDoListWidget extends StatefulWidget {
  const ToDoListWidget({
    Key? key,
    required this.toDoList,
  }) : super(key: key);

  final ToDoList toDoList;

  @override
  _ToDoListWidgetState createState() => _ToDoListWidgetState();
}

class _ToDoListWidgetState extends State<ToDoListWidget> {
  @override
  void initState() {
    // initialize the name of the to-do list
    widget.toDoList.name = Preferences.getListName();

    // initialize the tasks from the encoded json list
    if (Preferences.getTasksList() == "" || widget.toDoList.tasks.isEmpty) {
      widget.toDoList.tasks = [Task()];
    } else {
      var tasksJson = jsonDecode(Preferences.getTasksList()) as List;
      widget.toDoList.tasks =
          tasksJson.map((tasks) => Task.fromJson(tasks)).toList();

      // delete all the empty tasks
      for (int i = 0; i < widget.toDoList.tasks.length; i++) {
        if (!widget.toDoList.tasks[i].done &&
            widget.toDoList.tasks[i].title == "") {
          widget.toDoList.tasks.remove(widget.toDoList.tasks[i]);
        }
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController =
        TextEditingController(text: widget.toDoList.name);

    return ListView.builder(
      itemCount: widget.toDoList.tasks.length,
      itemBuilder: (context, i) {
        return TaskWidget(
          task: widget.toDoList.tasks[i],
          onDeleteTapped: () {
            setState(() {
              widget.toDoList.tasks.remove(widget.toDoList.tasks[i]);
            });
          },
          onCheckTapped: (value) async {
            setState(() {
              widget.toDoList.tasks[i].done = value!;
            });
            await Preferences.setTasksList(jsonEncode(widget.toDoList.tasks));
          },
          onTitleChanged: () async {
            await Preferences.setTasksList(jsonEncode(widget.toDoList.tasks));
          },
        );
      },
    );
  }
}
