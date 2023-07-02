import 'package:flutter/material.dart';
import 'package:to_do_list/const/colors.dart';
import 'package:to_do_list/widgets/task_view.dart';
import 'package:to_do_list/widgets/to_do_list/to_do_list_widget.dart';

import '../widgets/category.dart';
import '../widgets/to_do_list/task.dart';

class CategoryPage extends StatefulWidget {
  final Category category;

  const CategoryPage({required this.category, super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: false,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: primaryTextColor,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    widget.category.name,
                    style: const TextStyle(
                      color: primaryTextColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: primaryTextColor,
                    ),
                    onPressed: () {
                      setState(
                        () => widget.category.tasks.add(
                          Task(
                            color: widget.category.color,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 15),
              ToDoListWidget(
                toDoList: ToDoList(
                  tasks: widget.category.tasks,
                  color: widget.category.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
