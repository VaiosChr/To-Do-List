import "package:flutter/material.dart";
import "package:to_do_list/const/colors.dart";

class Task {
  String title = "";
  bool done = false;
  Color color = taskColors[0];

  Task({this.title = "", this.done = false, required this.color});

  // Map toJson() {
  //   return {
  //     "title": title,
  //     "done": done,
  //   };
  // }

  // factory Task.fromJson(dynamic json) {
  //   return Task(title: json["title"] as String, done: json["done"] as bool);
  // }

  // @override
  // String toString() {
  //   return '{$title, $done}';
  // }
}

class TaskWidget extends StatefulWidget {
  const TaskWidget({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController =
        TextEditingController(text: widget.task.title);

    return Expanded(
      child: ListTile(
        title: TextFormField(
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: widget.task.done ? greyTextColor : primaryTextColor,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "I have to...",
            hintStyle: TextStyle(
              color: lightTextColor,
            ),
          ),
          controller: textEditingController,
        ),
        leading: InkWell(
          onTap: () {
            setState(() => widget.task.done = !widget.task.done);
          },
          child: widget.task.done
              ? Container(
                  width: 24.0,
                  height: 24.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.task.color,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16.0,
                  ),
                )
              : Container(
                  width: 24.0,
                  height: 24.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    border: Border.all(
                      color: widget.task.color,
                      width: 2.0,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
