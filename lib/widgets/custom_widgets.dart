import 'package:flutter/material.dart';

import '../const/colors.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddButton({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.add,
        color: greyTextColor,
      ),
      onPressed: onPressed,
    );
  }
}
