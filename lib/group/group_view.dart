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
          return Container(
            margin: EdgeInsets.only(top: 10),
            alignment: Alignment.centerLeft,
            width: double.maxFinite,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[300],
            ),
            child: Text(widget.toDoListGroup[i].getName()),
          );
        },
      ),
    );
  }
}
