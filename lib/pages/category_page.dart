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
                    icon: const Icon(Icons.edit),
                    color: primaryTextColor,
                    onPressed: () {
                      String newCategoryName = widget.category.name;
                      Color newCategoryColor = widget.category.color;

                      TextEditingController controller =
                          TextEditingController(text: widget.category.name);

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              "Edit Category",
                              style: TextStyle(
                                color: primaryTextColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  controller: controller,
                                  style: const TextStyle(
                                    color: secondaryTextColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Enter name",
                                    hintStyle: const TextStyle(
                                      color: greyTextColor,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.5,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 15.0),
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () => controller.clear(),
                                    ),
                                  ),
                                  onChanged: (value) =>
                                      newCategoryName = value,
                                ),
                                const SizedBox(height: 20),
                                ColorPickerRow(
                                  onColorSelected: (selectedColor) =>
                                      newCategoryColor = selectedColor,
                                ),
                              ],
                            ),
                            actions: [
                        TextButton(
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color: primaryTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              letterSpacing: 1.5,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              letterSpacing: 1.5,
                            ),
                          ),
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              color: primaryTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              letterSpacing: 1.5,
                            ),
                          ),
                          onPressed: () {
                            // save the new category
                            widget.category.name = newCategoryName;
                            widget.category.color = newCategoryColor;
                            Navigator.pop(context);
                          },
                        ),
                      ],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Text(
                    "TASKS",
                    style: TextStyle(
                      color: greyTextColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: greyTextColor,
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
