import "package:flutter/material.dart";

class Task {
  String title = "";
  bool done = false;

  Task({this.title = "", this.done = false});

  Map toJson() {
    return {
     "title": this.title,
      "done": this.done,
    };
  }

  factory Task.fromJson(dynamic json) {
    return Task(title: json["title"] as String, done: json["done"] as bool);
  }

  @override
  String toString() {
    return '{ ${this.title}, ${this.done} }';
  }
}

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    Key? key,
    required this.onDeleteTapped,
    required this.onCheckTapped,
    required this.task,
  });

  final VoidCallback? onDeleteTapped;
  final ValueChanged<bool?>? onCheckTapped;
  final Task task;

  @override
  Widget build(BuildContext context) {
    TextEditingController _textEditingController = TextEditingController(text: task.title);
    return ListTile(
      title: TextFormField(
        style: TextStyle( 
          color: task.done ? Colors.grey : Colors.black,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "I have to...",
        ),
        onChanged: (text) {
          task.title = text;
        },
        controller: _textEditingController,
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete_outline_rounded),
        onPressed: onDeleteTapped,
      ),
      leading: Checkbox(
        value: task.done,
        onChanged: onCheckTapped,
      ),
    );
  }
}