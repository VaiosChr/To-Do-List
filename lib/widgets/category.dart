import 'package:flutter/material.dart';

import 'package:to_do_list/widgets/to_do_list/task.dart';
import 'package:to_do_list/const/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/category_page.dart';

class Category {
  String name;
  List<Task> tasks = [];
  Color color;

  Category({
    required this.name,
    required this.color,
    tasks,
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
  
  void tasksFromJson(Map<String, dynamic> json) {
    tasks = (json["tasks"] as List<dynamic>)
        .map((task) => Task.fromJson(task))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      'color': color.value.toRadixString(16),
      "tasks": tasks.map((task) => task.toJson()).toList(),
    };
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json["name"],
      color: Color(int.parse(json['color'], radix: 16)),
      tasks: (json["tasks"] as List<dynamic>)
          .map((task) => Task.fromJson(task))
          .toList(),
    );
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
      completedTaskCount =
          widget.category.tasks.where((task) => task.done).length;
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
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: widget.category.tasks.isNotEmpty
                    ? widget.category.getCompletedTasks() /
                        widget.category.tasks.length
                    : 0,
                backgroundColor: whiteColor,
                valueColor: AlwaysStoppedAnimation<Color>(
                  widget.category.color,
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
  final Color initialColor;

  const ColorPickerRow(
      {required this.onColorSelected, required this.initialColor, super.key});

  @override
  State<ColorPickerRow> createState() => _ColorPickerRowState();
}

class _ColorPickerRowState extends State<ColorPickerRow> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = taskColors.indexOf(widget.initialColor);
  }

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
