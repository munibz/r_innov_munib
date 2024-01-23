import 'package:flutter/material.dart';

class EmpRow extends StatelessWidget {
  final String title;
  final void Function()? onTap;

  const EmpRow({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        child: Text(
          title,
          textAlign: TextAlign.center,
        ),
        width: double.maxFinite,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color:
                  Colors.grey.shade300, // Choose the color of the bottom border
              width: 1.0, // Choose the width of the bottom border
            ),
          ),
        ),
      ),
    );
  }
}
