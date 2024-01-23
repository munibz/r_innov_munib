import 'package:flutter/material.dart';

class EmpButton extends StatelessWidget {
  final void Function()? onPressed;
  final Color color;
  final String title;
  final Color? focusColor;
  final Color foregroundColor;
  final bool isSelected;

  const EmpButton(
      {super.key,
      this.onPressed,
      required this.color,
      required this.title,
      required this.foregroundColor,
      this.focusColor,
      this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: isSelected ? foregroundColor : color,
      elevation: 0,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Text(
        title,
        style: TextStyle(color: isSelected ? color : foregroundColor),
      ),
    );
  }
}
