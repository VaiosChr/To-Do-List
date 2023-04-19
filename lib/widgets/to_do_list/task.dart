import "package:flutter/material.dart";

class Task {
  String title = "";
  bool done = false;

  Task({this.title = "", this.done = false});

  Map toJson() {
    return {
      "title": title,
      "done": done,
    };
  }

  factory Task.fromJson(dynamic json) {
    return Task(title: json["title"] as String, done: json["done"] as bool);
  }

  @override
  String toString() {
    return '{$title, $done}';
  }
}

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    super.key,
    required this.onDeleteTapped,
    required this.onCheckTapped,
    required this.onTitleChanged,
    required this.task,
  });

  final VoidCallback? onDeleteTapped;
  final ValueChanged<bool?>? onCheckTapped;
  final Function onTitleChanged;
  final Task task;

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController =
        TextEditingController(text: task.title);

    return ListTile(
      title: TextFormField(
        style: TextStyle(
          color: task.done ? Colors.grey : Colors.black,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "I have to...",
        ),
        onChanged: (text) {
          task.title = text;
          onTitleChanged();
        },
        controller: textEditingController,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline_rounded),
        onPressed: onDeleteTapped,
      ),
      leading: Checkbox(
        value: task.done,
        onChanged: onCheckTapped,
      ),
    );
  }
}
