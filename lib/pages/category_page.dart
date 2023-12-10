import 'package:flutter/material.dart';
import 'package:to_do_list/const/colors.dart';
import 'package:to_do_list/widgets/to_do_list/to_do_list_widget.dart';
import '../widgets/custom_widgets.dart';

class CategoryPage extends StatefulWidget {
  final ToDoList toDoList;

  const CategoryPage({
    required this.toDoList,
    super.key,
  });

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
                      size: 20,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    widget.toDoList.name,
                    style: const TextStyle(
                      color: primaryTextColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.edit_calendar_outlined),
                    color: primaryTextColor,
                    onPressed: () {
                      String newCategoryName = widget.toDoList.name;
                      Color newCategoryColor = widget.toDoList.color;

                      TextEditingController controller =
                          TextEditingController(text: widget.toDoList.name);

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
                                  onChanged: (value) => newCategoryName = value,
                                ),
                                const SizedBox(height: 20),
                                ColorPickerRow(
                                  initialColor: widget.toDoList.color,
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
                                  widget.toDoList.name = newCategoryName;
                                  widget.toDoList.color = newCategoryColor;

                                  setState(() {
                                    widget.toDoList
                                        .onColorChanged(newCategoryColor);
                                  });

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
              ToDoListWidget(
                toDoList: ToDoList(
                  tasks: widget.toDoList.tasks,
                  color: widget.toDoList.color,
                  key: widget.toDoList.key,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
