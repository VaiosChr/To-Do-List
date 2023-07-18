import "package:flutter/material.dart";
import "package:to_do_list/const/colors.dart";

class Task {
  String title = "";
  bool done = false;
  Color color = taskColors[0];

  Task({this.title = "", this.done = false, required this.color});
}

class TaskWidget extends StatefulWidget {
  final VoidCallback onDeleteTapped;

  const TaskWidget({
    super.key,
    required this.task,
    required this.onDeleteTapped,
  });

  final Task task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller =
        TextEditingController(text: widget.task.title);

    // return Expanded(
    //   child: ListTile(
    //     title: TextFormField(
    //       style: TextStyle(
    //         fontSize: 20,
    //         fontWeight: FontWeight.w500,
    //         color: widget.task.done ? greyTextColor : primaryTextColor,
    //       ),
    //       decoration: const InputDecoration(
    //         border: InputBorder.none,
    //         hintText: "New task",
    //         hintStyle: TextStyle(
    //           color: lightTextColor,
    //         ),
    //       ),
    //       onChanged: (value) => widget.task.title = value,
    //       controller: controller,
    //     ),
    //     leading: InkWell(
    //       onTap: () {
    //         setState(() => widget.task.done = !widget.task.done);
    //       },
    //       child: widget.task.done
    //           ? Container(
    //               width: 24.0,
    //               height: 24.0,
    //               decoration: BoxDecoration(
    //                 shape: BoxShape.circle,
    //                 color: widget.task.color,
    //               ),
    //               child: const Icon(
    //                 Icons.check,
    //                 color: Colors.white,
    //                 size: 16.0,
    //               ),
    //             )
    //           : Container(
    //               width: 24.0,
    //               height: 24.0,
    //               decoration: BoxDecoration(
    //                 shape: BoxShape.circle,
    //                 color: Colors.transparent,
    //                 border: Border.all(
    //                   color: widget.task.color,
    //                   width: 2.0,
    //                 ),
    //               ),
    //             ),
    //     ),
    //     trailing: IconButton(
    //       icon: const Icon(
    //         Icons.delete_outline,
    //       ),
    //       color: alertColor,
    //       onPressed: widget.onDeleteTapped,
    //     ),
    //   ),
    // );

    return Row(
      children: [
        InkWell(
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
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: widget.task.done ? greyTextColor : primaryTextColor,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "New task",
              hintStyle: TextStyle(
                color: lightTextColor,
              ),
            ),
            onChanged: (value) => widget.task.title = value,
            controller: controller,
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.delete_outline,
          ),
          color: alertColor,
          onPressed: widget.onDeleteTapped,
        ),
      ],
    );
  }
}
