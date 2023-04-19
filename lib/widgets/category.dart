import 'package:flutter/material.dart';

import 'package:to_do_list/widgets/to_do_list/task.dart';
import 'package:to_do_list/const/colors.dart';

class Category {
  String name;
  late List<Task> tasks;

  Category({
    required this.name,
    required this.tasks,
  });
}

class CategoryViewWidget extends StatelessWidget {
  const CategoryViewWidget({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: 200,
        height: 100,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              spreadRadius: 10,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${category.tasks.length} tasks",
              style: const TextStyle(
                color: greyTextColor,
                letterSpacing: 1.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              category.name,
              style: const TextStyle(
                color: secondaryTextColor,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: category.tasks.length > 0 ? completedTasks() / category.tasks.length : 0,
                backgroundColor: lightTextColor,
                valueColor: AlwaysStoppedAnimation<Color>(
                  fancyColors[0],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int completedTasks() {
    int completedTasks = 0;
    for (var task in category.tasks) {
      if (task.done) {
        completedTasks++;
      }
    }
    return completedTasks;
  }
}

class MultipleCategoryViewWidget extends StatefulWidget {
  MultipleCategoryViewWidget({super.key});

  List<Category> categories = [
    Category(
      name: "Work",
      tasks: [
        Task(done: true),
        Task(),
        Task(),
        Task(),
      ],
    ),
    Category(
      name: "Personal",
      tasks: [
        Task(done: true),
        Task(done: true),
        Task(done: true),
        Task(),
      ],
    ),
  ];

  @override
  State<MultipleCategoryViewWidget> createState() =>
      _MultipleCategoryViewWidgetState();
}

class _MultipleCategoryViewWidgetState
    extends State<MultipleCategoryViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "CATEGORIES",
          style: TextStyle(
            color: greyTextColor,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 15),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (var category in widget.categories)
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: CategoryViewWidget(category: category),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
