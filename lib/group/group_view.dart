import "package:flutter/material.dart";

import 'package:to_do_list/to_do_list/task.dart';
import 'package:to_do_list/to_do_list/to_do_list_widget.dart';

class GroupView extends StatefulWidget {
  final List<ToDoList> toDoListGroup;

  const GroupView({
    Key? key,
    required this.toDoListGroup,
  }) : super(key: key);

  @override
  _GroupViewState createState() => _GroupViewState();
}

class _GroupViewState extends State<GroupView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Group"),
      ),
      body: ListView.builder(
        itemCount: widget.toDoListGroup.length,
        itemBuilder: (context, i) {
          TextEditingController _textEditingController =
              TextEditingController(text: widget.toDoListGroup[i].name);

          return Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            width: double.maxFinite,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[300],
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 12,
                  width: 300,
                  child: TextFormField(
                    //check if the name is too big and add [...] after it
                    // name.length > 25 ? name.substring(0, 25) + "..." : name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "To-do list name..."),
                    onChanged: (text) {
                      widget.toDoListGroup[i].name = text;
                    },
                    controller: _textEditingController,
                  ),
                ),
                Positioned(
                  right: 10,
                  child: IconButton(
                    icon: Icon(Icons.delete_outline_rounded),
                    onPressed: () {
                      setState(() {
                        widget.toDoListGroup.remove(widget.toDoListGroup[i]);
                      });
                    },
                  ),
                ),
                Positioned(
                  bottom: 15,
                  left: 12,
                  child: Text(
                    "total tasks: " +
                        widget.toDoListGroup[i].tasks.length.toString(),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(Icons.add),
        onPressed: () {
          setState(
            () => widget.toDoListGroup.add(
              ToDoList(
                tasks: [Task()],
              ),
            ),
          );
        },
      ),
    );
  }
}
