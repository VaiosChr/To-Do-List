import 'package:flutter/material.dart';

import 'package:to_do_list/widgets/to_do_list/task.dart';
import 'package:to_do_list/const/colors.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class Category {
  String name;
  //@TODO: remove the constant initialization, when finished with the logic
  List<Task> tasks = [Task(), Task(), Task(done: true)];
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
                value: category.tasks.isNotEmpty
                    ? category.getCompletedTasks() / category.tasks.length
                    : 0,
                backgroundColor: lightTextColor,
                valueColor: AlwaysStoppedAnimation<Color>(
                  category.color,
                ),
              ),
            ),
          ],
        ),
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
  const ColorPickerRow({super.key});

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
          onTap: () => selectColor(index),
        ),
      ),
    );
  }
}

class MultipleCategoryViewWidget extends StatefulWidget {
  MultipleCategoryViewWidget({super.key});

  List<Category> categories = [
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
              onPressed: () {
                showAddCategoryDialog(context);
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

  void showAddCategoryDialog(BuildContext context) {
    String categoryName = "";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Category name...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: greyTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                onChanged: (value) {
                  categoryName = value;
                },
              ),
              const SizedBox(height: 15),
              const ColorPickerRow(),
            ],
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(
                  color: primaryTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  letterSpacing: 1.5,
                ),
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(
                  color: primaryTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  letterSpacing: 1.5,
                ),
              ),
              child: const Text('Save'),
              onPressed: () {
                // Save the category name and color
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
  }
}
