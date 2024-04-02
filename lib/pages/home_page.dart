import 'package:flutter/material.dart';

import 'package:to_do_list/widgets/custom_widgets.dart';
import 'package:to_do_list/widgets/multiple_categories.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //@TODO: figure out scrolling
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: const [
            TitleText(text: "What's up, Vaios?"),
            SizedBox(height: 30),
            MultipleCategoryViewWidget(),
          ],
        ),
      ),
    );
  }
}
