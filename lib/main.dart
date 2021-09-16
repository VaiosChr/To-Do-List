import "package:flutter/material.dart";

import "./task.dart";

void main() => runApp(MyApp(streamController.stream));

//the main class of the app
class MyApp extends StatefulWidget {
  final Stream<int> stream;

  MyApp(this.stream);

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  final tabs = ["Home", "Settings"];
  var tasks = [Task(0)];

  //deletes the task at the index provided as an argument 
  void deleteTaskAt(int index) {
    setState(() => tasks.removeAt(index));

    for (int i = index + 1; i < tasks.length; i++) {
      tasks[i].setId(tasks[i].getId() - 1);
    }
  }

  @override
  void initState() {
    super.initState();
    widget.stream.listen((index) {
      deleteTaskAt(0);
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
        //the problem lies here, while displaying the list!!!
        body: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (BuildContext context, int index) {
            return tasks[index];
          },
        ),
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(Icons.add),
          onPressed: () {
            //DEBUG:
            // print(tasks.length);
            setState(() => tasks.add(Task(tasks.length)));
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
