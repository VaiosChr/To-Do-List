import 'package:flutter/material.dart';

import 'package:to_do_list/const/colors.dart';
import 'package:to_do_list/preferences.dart';
import 'package:to_do_list/widgets/to_do_list/to_do_list_widget.dart';
import 'package:to_do_list/widgets/category.dart';
import 'package:to_do_list/widgets/custom_widgets.dart';

class MultipleCategoryViewWidget extends StatefulWidget {
  const MultipleCategoryViewWidget({super.key});

  @override
  State<MultipleCategoryViewWidget> createState() =>
      _MultipleCategoryViewWidgetState();
}

class _MultipleCategoryViewWidgetState
    extends State<MultipleCategoryViewWidget> {
  List<ToDoList> categories = [];
  ToDoList todaysTasks = ToDoList(
    name: "Today's Tasks",
    color: greyTextColor,
    tasks: [],
    isTodays: true,
    key: UniqueKey().toString(),
  );

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      setState(() {
        loadCategoriesFromPrefs();
        loadTodaysTasksFromPrefs();
      });
    });
  }

  void loadCategoriesFromPrefs() async {
    List<ToDoList> tempCategories =
        await SharedPreferencesService.loadCategories();

    if (tempCategories.isNotEmpty) {
      setState(() {
        categories = tempCategories;
      });
    }
  }

  void loadTodaysTasksFromPrefs() async {
    ToDoList tempTodaysTasks = await SharedPreferencesService.loadTodaysTasks();

    if (tempTodaysTasks.tasks.isNotEmpty) {
      setState(() {
        todaysTasks = tempTodaysTasks;
      });
    }
  }

  void saveTodaysTasksToPrefs() {
    SharedPreferencesService.saveTodaysTasks(todaysTasks);
  }

  void saveCategoriesToPrefs() {
    SharedPreferencesService.saveCategories(categories);
  }

  void deleteCategory(int index) async {
    final bool confirm = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Confirm Delete",
            style: TextStyle(
              color: primaryTextColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          content: Text(
            "Are you sure you want to delete ${categories[index].name}?",
            style: const TextStyle(
              color: secondaryTextColor,
              fontSize: 17,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
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
              onPressed: () => Navigator.pop(context, false),
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
                'Delete',
                style: TextStyle(
                  color: primaryTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  letterSpacing: 1.5,
                ),
              ),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        );
      },
    );

    if (!confirm) return;
    setState(() => categories.removeAt(index));
    SharedPreferencesService.saveCategories(categories);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const GreyText(text: 'CATEGORIES'),
            IconButton(
              icon: const Icon(Icons.add, color: greyTextColor),
              onPressed: () async {
                ToDoList newToDoList = ToDoList(
                  name: "New Category",
                  color: taskColors[0],
                  tasks: [],
                  key: UniqueKey().toString(),
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
                            onChanged: (value) => newToDoList.name = value,
                          ),
                          const SizedBox(height: 20),
                          ColorPickerRow(
                            initialColor: taskColors[0],
                            onColorSelected: (selectedColor) =>
                                newToDoList.color = selectedColor,
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
                            'Add',
                            style: TextStyle(
                              color: primaryTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              letterSpacing: 1.5,
                            ),
                          ),
                          onPressed: () {
                            SharedPreferencesService.saveCategories(categories);
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
                  setState(() => categories.add(newToDoList));
                  SharedPreferencesService.saveCategories(categories);
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
                  child: CategoryFrontView(
                    toDoList: categories[i],
                    onDeleteTapped: () => deleteCategory(i),
                  ),
                ),
              if (categories.isNotEmpty)
                CategoryFrontView(
                  toDoList: categories[categories.length - 1],
                  onDeleteTapped: () => deleteCategory(categories.length - 1),
                ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        ToDoListWidget(
          toDoList: todaysTasks,
        ),
      ],
    );
  }
}
