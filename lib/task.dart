import "package:flutter/material.dart";
import "dart:async";

StreamController<int> streamController = StreamController<int>();

class Task extends StatefulWidget {
  int _id = -1;

  Task(this._id);

  void setId(int id) => this._id = id;

  int getId() {
    return this._id;
  }

  @override
  State<StatefulWidget> createState() {
    return _TaskState(this._id);
  }
}

class _TaskState extends State<Task> {
  int _id = -1;
  bool _checked = false;
  TextEditingController _controller = TextEditingController(text: "");

  _TaskState(this._id);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      style: TextStyle(
        color: _checked ? Colors.grey : Colors.black,
        fontWeight: FontWeight.normal,
        fontSize: 20,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "I have to...",
        prefixIcon: IconButton(
          icon: Icon(
            _checked ? Icons.check_box : Icons.check_box_outline_blank,
          ),
          onPressed: () {
            setState(() => _checked = !_checked);
          },
        ),
        suffixIcon: IconButton(
          icon: Icon(Icons.delete_outline_rounded),
          onPressed: () {
            setState(() {
              //TODO: implement the deletion algorithm
              streamController.add(this._id);
            });
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}