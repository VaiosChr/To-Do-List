import 'package:flutter/material.dart';
import 'package:to_do_list/const/colors.dart';
import 'package:to_do_list/widgets/task_view.dart';

import '../widgets/category.dart';
import '../widgets/multiple_categories.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        top: true,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "What's up, Vaios!",
                  style: TextStyle(
                    color: primaryTextColor,
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 30),
                MultipleCategoryViewWidget(),
                const SizedBox(height: 15),
                Column(
                  children: [
                    TodaysTasksView(
                      category: Category(
                        name: "Today's Tasks",
                        color: taskColors[0],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
