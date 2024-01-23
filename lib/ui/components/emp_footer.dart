import 'package:flutter/material.dart';

class EndFooter extends StatelessWidget {
  final String title;

  const EndFooter({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      fillOverscroll: true,
      child: Container(
        height: 50,
        width: double.maxFinite,
        color: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            title,
            style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
          ),
        ),
      ),
    );
  }
}
