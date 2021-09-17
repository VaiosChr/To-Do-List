import "package:flutter/material.dart";

class Task {
  String title = "";
  bool done = false;
}

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    Key? key,
    required this.onTitleChanged,
    required this.onDeleteTapped,
    required this.onCheckTapped,
    required this.task,
  }) : super(key: key);

  final ValueChanged<String>? onTitleChanged;
  final VoidCallback? onDeleteTapped;
  final ValueChanged<bool?>? onCheckTapped;
  final Task task;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextField(
        style: TextStyle(
          color: task.done ? Colors.grey : Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: 20,
        ),
        controller: TextEditingController(text: task.title),
        onChanged: onTitleChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "I have to...",
        ),
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
