import 'package:flutter/material.dart';

import 'package:to_do_list/const/colors.dart';
import 'package:to_do_list/widgets/to_do_list/to_do_list_widget.dart';
import 'package:to_do_list/pages/category_page.dart';

class CategoryFrontView extends StatefulWidget {
  const CategoryFrontView({
    super.key,
    required this.toDoList,
    required this.onDeleteTapped,
  });

  final ToDoList toDoList;
  final VoidCallback onDeleteTapped;

  @override
  State<CategoryFrontView> createState() => _CategoryFrontViewState();
}

class _CategoryFrontViewState extends State<CategoryFrontView> {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.toDoList.tasks.length} task${widget.toDoList.tasks.length != 1 ? "s" : ""}",
                  style: const TextStyle(
                    color: greyTextColor,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                  ),
                  color: alertColor,
                  iconSize: 18,
                  onPressed: widget.onDeleteTapped,
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              widget.toDoList.name,
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
                value: widget.toDoList.tasks.isNotEmpty
                    ? widget.toDoList.getCompletedTasks() /
                        widget.toDoList.tasks.length
                    : 0,
                backgroundColor: whiteColor,
                valueColor: AlwaysStoppedAnimation<Color>(
                  widget.toDoList.color,
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
            builder: (context) => CategoryPage(
              toDoList: widget.toDoList,
            ),
          ),
        ).then((value) {
          setState(() {});
        });
      },
    );
  }
}
