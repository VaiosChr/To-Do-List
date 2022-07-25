import 'dart:convert';

import "package:flutter/material.dart";

import 'package:to_do_list/to_do_list/task.dart';
import 'package:to_do_list/to_do_list/to_do_list_widget.dart';

import '../preferences.dart';

// ignore: must_be_immutable
class GroupView extends StatefulWidget {
  late List<ToDoList> group;

  GroupView({
    Key? key,
    required this.group,
  }) : super(key: key);

  @override
  _GroupViewState createState() => _GroupViewState();
}

class _GroupViewState extends State<GroupView> {
  @override
  void initState() {
    //todo: initialize the group variable from the json list
    if (Preferences.getGroupList() == "" || widget.group.length == 0) {
      widget.group = [ToDoList(tasks: [Task()])];
    } else {
      //todo: this throws an error 
      var groupJson = jsonDecode(Preferences.getGroupList()) as List;
      widget.group = groupJson.map((list) => ToDoList.fromJson(list)).toList();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Group"),
      ),
      body: ListView.builder(
        itemCount: widget.group.length,
        itemBuilder: (context, i) {
          TextEditingController _textEditingController =
              TextEditingController(text: widget.group[i].name);

          return GestureDetector(
            child: Container(
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
                    top: 15,
                    left: 12,
                    width: 300,
                    child: Text(
                      // ignore: unnecessary_null_comparison
                      _textEditingController.text == null ? (_textEditingController.text.length > 25
                          ? _textEditingController.text.substring(0, 25) + "..."
                          : _textEditingController.text) : "New list",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 17,
                    child: IconButton(
                      icon: Icon(Icons.delete_outline_rounded),
                      onPressed: () {
                        setState(() {
                          widget.group.remove(widget.group[i]);
                        });
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 15,
                    left: 12,
                    child: Text(
                      "total tasks: " +
                          widget.group[i].tasks.length.toString(),
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () => Navigator.pushNamed(context, "/list"),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(Icons.add),
        onPressed: () async {
          setState(
            () => widget.group.add(
              ToDoList(
                tasks: [Task()],
              ),
            ),
          );
          await Preferences.setGroupList(jsonEncode(widget.group));
        },
      ),
    );
  }
}
