import 'package:flutter/material.dart';

import 'package:to_do_list/const/colors.dart';
import 'package:to_do_list/widgets/to_do_list/to_do_list_widget.dart';

import '../pages/category_page.dart';

class Category {
  String name;
  ToDoList toDoList;
  // Color color;

  Category({
    required this.name,
    // required this.color,
    required this.toDoList,
  });

  void setName(String newName) => name = newName;

  int getCompletedTasks() {
    int completedTasks = 0;

    for (var task in toDoList.tasks) {
      if (task.done) {
        completedTasks++;
      }
    }
    return completedTasks;
  }

  // void tasksFromJson(Map<String, dynamic> json) {
  //   tasks = (json["tasks"] as List<dynamic>)
  //       .map((task) => Task.fromJson(task))
  //       .toList();
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     "name": name,
  //     'color': color.value.toRadixString(16),
  //     // "tasks": tasks.map((task) => task.toJson()).toList(),
  //   };
  // }

  // factory Category.fromJson(Map<String, dynamic> json) {
  //   return Category(
  //     name: json["name"],
  //     color: Color(int.parse(json['color'], radix: 16)),
  //     // tasks: (json["tasks"] as List<dynamic>)
  //     //     .map((task) => Task.fromJson(task))
  //     //     .toList(),
  //   );
  // }
}

class CategoryViewWidget extends StatefulWidget {
  const CategoryViewWidget({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  State<CategoryViewWidget> createState() => _CategoryViewWidgetState();
}

class _CategoryViewWidgetState extends State<CategoryViewWidget> {
  int completedTaskCount = 0;

  void markTaskAsDone(int index) {
    setState(() {
      widget.category.toDoList.tasks[index].done = true;
      completedTaskCount =
          widget.category.toDoList.tasks.where((task) => task.done).length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(10),
        width: 200,
        decoration: BoxDecoration(
          color: tileColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.category.toDoList.tasks.length} tasks",
              style: const TextStyle(
                color: greyTextColor,
                letterSpacing: 1.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              widget.category.name,
              style: const TextStyle(
                color: secondaryTextColor,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: widget.category.toDoList.tasks.isNotEmpty
                    ? widget.category.getCompletedTasks() /
                        widget.category.toDoList.tasks.length
                    : 0,
                backgroundColor: whiteColor,
                valueColor: AlwaysStoppedAnimation<Color>(
                  widget.category.toDoList.color,
                ),
                minHeight: 6,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryPage(category: widget.category),
          ),
        ).then((value) {
          setState(() {});
        });
      },
    );
  }
}
