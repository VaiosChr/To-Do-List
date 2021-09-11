import "package:flutter/material.dart";

import "./task.dart";

void main() => runApp(MyApp(streamController.stream));

class MyApp extends StatefulWidget {
  final Stream<int> stream;

  MyApp(this.stream);

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  int taskCounter = 0;
  int _currentIndex = 0;
  final tabs = ["Home", "Settings"];
  var tasks = [Task(0)];

  void deleteTaskAt(int index) {
    for (int i = index + 1; i < tasks.length; i++) {
      tasks[i].setId(tasks[i].getId() - 1);
    }

    setState(() => tasks.removeAt(index));
  }

  @override
  void initState() {
    super.initState();
    widget.stream.listen((index) {
      deleteTaskAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(tabs[_currentIndex]),
        ),
        body: Column(
          children: [
            ...tasks.map((task) => Task(0)).toList(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(Icons.add),
          onPressed: () {
            setState(() => tasks.add(Task(++taskCounter)));
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            )
          ],
          onTap: (index) {
            setState(() => _currentIndex = index);
          },
        ),
      ),
    );
  }
}
