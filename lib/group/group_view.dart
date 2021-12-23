import "package:flutter/material.dart";

import 'package:to_do_list/to_do_list/to_do_list_view.dart';

class GroupView extends StatefulWidget {
  final List<ToDoListView> toDoListGroup;
  const GroupView({
    Key? key,
    required this.toDoListGroup,
  }) : super(key: key);

  @override
  _GroupViewState createState() => _GroupViewState();
}

class _GroupViewState extends State<GroupView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Group"),
      ),
      body: ListView.builder(
        itemCount: widget.toDoListGroup.length,
        itemBuilder: (context, i) {
          String name = widget.toDoListGroup[i].getName();

          return Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            width: double.maxFinite,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[300],
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  left: 10,
                  child: Text(
                    //check if the name is too big and add [...] after it
                    name.length > 30 ? name.substring(0, 30) + "..." : name,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
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
            setState(() => widget.toDoListGroup.add(ToDoListView()));
          }),
    );
  }
}
