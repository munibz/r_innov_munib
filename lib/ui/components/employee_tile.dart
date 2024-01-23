import 'package:flutter/material.dart';

class EmployeeTile extends StatelessWidget {
  final String name;
  final String designation;
  final String fromDate;
  final String? toDate;
  final Key dismissKey;
  final void Function() onEdit;
  final void Function(DismissDirection)? onDismissed;

  const EmployeeTile(
      {Key? key,
      required this.name,
      required this.designation,
      required this.fromDate,
      this.toDate,
      required this.dismissKey,
      this.onDismissed,
      required this.onEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: dismissKey,
      onDismissed: onDismissed,
      background: Container(
        color: Colors.red,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
      child: InkWell(
        onTap: onEdit,
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                designation,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                name,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                toDate == null ? 'From $fromDate' : '${fromDate} - ${toDate}',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              )
            ],
          ),
        ),
      ),
    );
  }
}
