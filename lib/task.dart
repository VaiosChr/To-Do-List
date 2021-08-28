import "package:flutter/material.dart";

class Task extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TaskState();
  }
}

class _TaskState extends State<Task> {
  bool checked = false;
  TextEditingController _controller = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      style: TextStyle(
        color: checked ? Colors.grey : Colors.black,
        fontWeight: FontWeight.normal,
        fontSize: 20,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "I have to...",
        prefixIcon: IconButton(
          icon: Icon(
            checked ? Icons.check_box  : Icons.check_box_outline_blank,
          ),
          onPressed: () {
            setState(() => checked = !checked);
          },
        ),
        suffixIcon: IconButton(
          icon: Icon(Icons.delete_outline_rounded),
          onPressed: () {
            //TODO: implement the deletion algorithm!
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