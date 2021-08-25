import "package:flutter/material.dart";

import "./task.dart";

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var tasks = [Task()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(children: [
            Text("To-Do List"),
          ]),
        ),
        body: Column(children: [
          ...tasks.map((task) => Task()).toList(),
        ]),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            setState(() => tasks.add(Task()));
            setState(() {});
          },
        ),
      ),
    );
  }
}
