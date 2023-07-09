import 'package:flutter/material.dart';

import 'package:to_do_list/widgets/to_do_list/task.dart';
import 'package:to_do_list/const/colors.dart';

import '../pages/category_page.dart';

class Category {
  String name;
  //@TODO: remove the constant initialization, when finished with the logic
  List<Task> tasks = [];
  Color color;

  Category({
    required this.name,
    required this.color,
  });

  void setName(String newName) => name = newName;

  int getCompletedTasks() {
    int completedTasks = 0;

    for (var task in tasks) {
      if (task.done) {
        completedTasks++;
      }
    }
    return completedTasks;
  }
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
      widget.category.tasks[index].done = true;
      completedTaskCount = widget.category.tasks.where((task) => task.done).length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: GestureDetector(
        child: Container(
          padding: const EdgeInsets.all(10),
          width: 200,
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
                "${widget.category.tasks.length} tasks",
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
              ),
              const SizedBox(height: 25),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: widget.category.tasks.isNotEmpty
                      ? widget.category.getCompletedTasks() /
                          widget.category.tasks.length
                      : 0,
                  backgroundColor: lightTextColor,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    widget.category.color,
                  ),
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
          );
        },
      ),
    );
  }
}

class ColorPickerItem extends StatelessWidget {
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  const ColorPickerItem({
    super.key,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: selected
            ? Icon(
                Icons.check,
                color: getIconColor(),
              )
            : null,
      ),
    );
  }

  Color getIconColor() {
    double luminance =
        (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}

class ColorPickerRow extends StatefulWidget {
  final ValueChanged<Color> onColorSelected;

  const ColorPickerRow({required this.onColorSelected, super.key});

  @override
  State<ColorPickerRow> createState() => _ColorPickerRowState();
}

class _ColorPickerRowState extends State<ColorPickerRow> {
  int selectedIndex = 0;

  void selectColor(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        taskColors.length,
        (index) => ColorPickerItem(
          color: taskColors[index],
          selected: index == selectedIndex,
          // onTap: () => selectColor(index),
          onTap: () {
            selectColor(index);
            widget.onColorSelected(taskColors[index]);
          },
        ),
      ),
    );
  }
}

class MultipleCategoryViewWidget extends StatefulWidget {
  MultipleCategoryViewWidget({super.key});

  final List<Category> categories = [
    Category(
      name: "Work",
      color: taskColors[0],
    ),
    Category(
      name: "Personal",
      color: taskColors[2],
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
                  color: taskColors[0],
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
                            onChanged: (value) => newCategory.name = value,
                          ),
                          const SizedBox(height: 20),
                          ColorPickerRow(
                            onColorSelected: (selectedColor) =>
                                newCategory.color = selectedColor,
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
                            // save the new category
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
                  setState(() => widget.categories.add(newCategory));
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
