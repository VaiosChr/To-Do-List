import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:to_do_list/widgets/to_do_list/task.dart';
import 'package:to_do_list/const/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/widgets/to_do_list/to_do_list_widget.dart';

import 'category.dart';
import 'custom_widgets.dart';

class MultipleCategoryViewWidget extends StatefulWidget {
  const MultipleCategoryViewWidget({super.key});

  @override
  State<MultipleCategoryViewWidget> createState() =>
      _MultipleCategoryViewWidgetState();
}

class _MultipleCategoryViewWidgetState
    extends State<MultipleCategoryViewWidget> {
  List<Category> categories = [
    Category(
      name: "Work",
      toDoList: ToDoList(
        name: "Work",
        color: taskColors[0],
        tasks: [
          Task(
            title: "Finish the project",
            color: taskColors[0],
            done: false,
          ),
          Task(
            title: "Send the project",
            color: taskColors[0],
            done: false,
          ),
          Task(
            title: "Get paid",
            color: taskColors[0],
            done: false,
          ),
        ],
      ),
    ),
    Category(
      name: "Home",
      toDoList: ToDoList(
        name: "Home",
        color: taskColors[1],
        tasks: [
          Task(
            title: "Clean the house",
            color: taskColors[1],
            done: false,
          ),
          Task(
            title: "Cook dinner",
            color: taskColors[1],
            done: false,
          ),
          Task(
            title: "Do the laundry",
            color: taskColors[1],
            done: false,
          ),
        ],
      ),
    ),
    Category(
      name: "Personal",
      toDoList: ToDoList(
        name: "Personal",
        color: taskColors[2],
        tasks: [
          Task(
            title: "Go to the gym",
            color: taskColors[2],
            done: false,
          ),
          Task(
            title: "Read a book",
            color: taskColors[2],
            done: false,
          ),
          Task(
            title: "Learn something new",
            color: taskColors[2],
            done: false,
          ),
        ],
      ),
    ),];

  // @override
  // void initState() {
  //   super.initState();
  //   loadCategories().then((value) {
  //     setState(() {
  //       categories = value;
  //     });
  //   });
  // }

  // Future<List<Category>> loadCategories() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // prefs.clear();
  //   List<String> categoryStrings = prefs.getStringList('categories') ?? [];

  //   List<Category> categories = categoryStrings.map((e) {
  //     Map<String, dynamic> categoryMap = json.decode(e);
  //     return Category.fromJson(categoryMap);
  //   }).toList();

  //   return categories;
  // }

  // Future<void> saveCategories(List<Category> categories) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   List<String> categoryStrings = categories.map((e) {
  //     return json.encode(e.toJson());
  //   }).toList();

  //   await prefs.setStringList('categories', categoryStrings);
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            IconButton(
              icon: const Icon(Icons.add, color: greyTextColor),
              onPressed: () async {
                Category newCategory = Category(
                  name: "New Category",
                  toDoList: ToDoList(
                    name: "New Category",
                    color: taskColors[0],
                    tasks: [],
                  ),
                );
                TextEditingController controller =
                    TextEditingController(text: "New Category");

                final selectedOption = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                        "Add New Category",
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
                            maxLength: 16,
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
                                vertical: 10.0,
                                horizontal: 15.0,
                              ),
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
                            onChanged: (value) => newCategory.name = value,
                          ),
                          const SizedBox(height: 20),
                          ColorPickerRow(
                            initialColor: taskColors[0],
                            onColorSelected: (selectedColor) =>
                                newCategory.toDoList.color = selectedColor,
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
                            Navigator.pop(context, false);
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
                          onPressed: () async {
                            // await saveCategories(categories);
                            Navigator.pop(context, true);
                          },
                        ),
                      ],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    );
                  },
                );

                if (selectedOption != null && selectedOption) {
                  setState(() => categories.add(newCategory));
                  // saveCategories(categories);
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 15),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 0; i < categories.length - 1; i++)
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: CategoryViewWidget(
                    category: categories[i],
                  ),
                ),
              if (categories.isNotEmpty) CategoryViewWidget(
                category: categories[categories.length - 1],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
