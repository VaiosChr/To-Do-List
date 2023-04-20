import "package:flutter/material.dart";
import "package:to_do_list/const/colors.dart";

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

// class TaskWidget extends StatelessWidget {
//   const TaskWidget({
//     super.key,
//     required this.onDeleteTapped,
//     required this.onCheckTapped,
//     required this.onTitleChanged,
//     required this.task,
//   });

//   final VoidCallback? onDeleteTapped;
//   final ValueChanged<bool?>? onCheckTapped;
//   final Function onTitleChanged;
//   final Task task;

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController textEditingController =
//         TextEditingController(text: task.title);

//     return ListTile(
//       title: TextFormField(
//         style: TextStyle(
//           color: task.done ? Colors.grey : Colors.black,
//         ),
//         decoration: const InputDecoration(
//           border: InputBorder.none,
//           hintText: "I have to...",
//         ),
//         onChanged: (text) {
//           task.title = text;
//           onTitleChanged();
//         },
//         controller: textEditingController,
//       ),
//       trailing: IconButton(
//         icon: const Icon(Icons.delete_outline_rounded),
//         onPressed: onDeleteTapped,
//       ),
//       leading: Checkbox(
//         value: task.done,
//         onChanged: onCheckTapped,
//       ),
//     );
//   }
// }

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

    return ListTile(
      title: TextFormField(
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: widget.task.done ? greyTextColor : primaryTextColor,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "I have to...",
        ),
        controller: textEditingController,
      ),
      leading: InkWell(
        onTap: () {
          setState(() {
            widget.task.done = !widget.task.done;
          });
        },
        child: Container(
          width: 24.0,
          height: 24.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.task.done ? fancy1 : Colors.transparent,
            border:
                widget.task.done ? null : Border.all(color: fancy1, width: 2.0),
          ),
          child: widget.task.done
              ? const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16.0,
                )
              : null,
        ),
      ),
    );
  }
}
