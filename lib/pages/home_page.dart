import 'package:flutter/material.dart';
import 'package:to_do_list/const/colors.dart';

import '../widgets/custom_widgets.dart';
import '../widgets/to_do_list/to_do_list_widget.dart';
import '../widgets/multiple_categories.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      //@TODO: figure out scrolling
      body: SafeArea(
        bottom: true,
        top: true,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TitleText(text: "What's up, Vaios?"),
              SizedBox(height: 30),
              MultipleCategoryViewWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
