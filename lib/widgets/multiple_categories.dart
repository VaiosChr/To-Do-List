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

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      setState(() {
        loadCategoriesFromPrefs();
      });
    });
  }

  void loadCategoriesFromPrefs() async {
    categories = await SharedPreferencesService.loadCategories();
  }

  void saveCategoriesFromPrefs() {
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
                ToDoList newToDoList = ToDoList(
                  name: "New Category",
                  color: taskColors[0],
                  tasks: [],
                  key: UniqueKey(),
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
                            'Save',
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
                  ),
                ),
              if (categories.isNotEmpty)
                CategoryFrontView(
                  toDoList: categories[categories.length - 1],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
