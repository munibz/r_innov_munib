import 'package:flutter/material.dart';

import '../../utils/const.dart';

class StickyHeader extends StatelessWidget {
  final String title;
  const StickyHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        width: double.maxFinite,
        color: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 15, left: 10),
          child: Text(
            title,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: kprimaryColor),
          ),
        ),
      ),
    );
  }
}
