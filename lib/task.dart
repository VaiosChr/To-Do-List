import "package:flutter/material.dart";

class Task extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TaskState();
  }
}

class _TaskState extends State<Task> {
  bool checked = false;
  late FocusNode _node;
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(checked ? Icons.check_box : Icons.check_box_outline_blank),
          onPressed: () {
            setState(() => checked = !checked);
          },
        ),
        Flexible(
          child: EditableText(
            maxLines: null,
            focusNode: _node,
            controller: _controller,
            backgroundCursorColor: Colors.black,
            style: TextStyle(
              color: checked ? Colors.grey : Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 20,
            ),
            cursorColor: Colors.black,
          ),
        ),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            //TODO: implement the deletion algorithm!
          },
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _node = FocusNode(debugLabel: "Button");
  }
}
