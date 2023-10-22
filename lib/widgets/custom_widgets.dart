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

  const ColorPickerRow({
    required this.onColorSelected,
    required this.initialColor,
    super.key,
  });

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
          onTap: () {
            selectColor(index);
            widget.onColorSelected(taskColors[index]);
          },
        ),
      ),
    );
  }
}