import "package:flutter/material.dart";

import "./task.dart";

void main() => runApp(MyApp());

//the main class of the app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "To-Do List",
      home: ToDoListView(),
    );
  }
}

class ToDoListView extends StatefulWidget {
  ToDoListView({Key? key}) : super(key: key);

  @override
  _ToDoListViewState createState() => _ToDoListViewState();
}

class _ToDoListViewState extends State<ToDoListView> {
  late List<Task> tasks;

  @override
  void initState() {
    tasks = [Task()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To-Do List"),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, i) {
          return TaskWidget(
            task: tasks[i],
            onDeleteTapped: () => setState(() => tasks.remove(tasks[i])),
            onTitleChanged: (String value) =>
                setState(() => tasks[i].title = value),
            onCheckTapped: (bool? value) {
              setState(() {
                tasks[i].done = !tasks[i].done;
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(Icons.add),
        onPressed: () {
          setState(() => tasks.add(Task()));
        },
      ),
    );
  }
}
