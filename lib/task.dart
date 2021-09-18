import "package:flutter/material.dart";

class Task {
  String title;
  bool done;

  Task(this.title, {this.done: false});
}

class TaskWidget extends StatefulWidget {
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
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController(text: widget.task.title);
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextField(
        style: TextStyle(
          color: widget.task.done ? Colors.grey : Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: 20,
        ),
        controller: _textEditingController,
        onChanged: widget.onTitleChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "I have to...",
        ),
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete_outline_rounded),
        onPressed: widget.onDeleteTapped,
      ),
      leading: Checkbox(
        value: widget.task.done,
        onChanged: widget.onCheckTapped,
      ),
    );
  }
}
