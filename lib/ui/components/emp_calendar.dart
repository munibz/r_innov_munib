import 'package:assignment_2/utils/const.dart';
import 'package:assignment_2/ui/components/emp_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef ValueSelectedCallback = void Function(String? selectedValue);

class EmpCalendar extends StatefulWidget {
  final ValueSelectedCallback onValueSelected;

  const EmpCalendar({super.key, required this.onValueSelected});

  @override
  State<EmpCalendar> createState() => _EmpCalendarState();
}

class _EmpCalendarState extends State<EmpCalendar> {
  final Map<String, dynamic> days = {"No Date": null, "Today": DateTime.now()};
  ValueNotifier<String> selectedOption = ValueNotifier<String>("No Date");
  ValueNotifier<String?> selectedDate = ValueNotifier(null);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    selectedOption.dispose();
    selectedDate.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Container(
                margin: EdgeInsets.all(10),
                child: ValueListenableBuilder(
                  valueListenable: selectedOption,
                  builder: (context, value, child) => GridView.builder(
                    shrinkWrap: true,
                    itemCount: days.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 5,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                    itemBuilder: (context, index) {
                      return EmpButton(
                        onPressed: () {
                          selectedOption.value = days.keys.elementAt(index);
                          if (days.values.elementAtOrNull(index) == null) {
                            selectedDate.value = null;
                          } else {
                            selectedDate.value = DateFormat('d MMM yyyy')
                                .format(days.values.elementAt(index));
                          }
                        },
                        isSelected:
                            days.keys.elementAt(index) == selectedOption.value,
                        color: ksecondaryColor,
                        focusColor: kprimaryColor,
                        title: days.keys.elementAt(index),
                        foregroundColor: kprimaryColor,
                      );
                    },
                  ),
                ),
              ),
            ),
            Flexible(
              child: CalendarDatePicker(
                initialDate: DateTime.now(),
                firstDate: DateTime(2021),
                lastDate: DateTime.now().add(Duration(days: 100000)),
                onDateChanged: (DateTime value) {
                  days.clear();
                  days.addAll(setDateList(value));
                  if (selectedOption.value != "Today") {
                    selectedOption.value = days.entries
                        .firstWhere(
                          (element) =>
                              (element.value as DateTime).day ==
                              DateTime.now().day,
                        )
                        .key;
                  } else {
                    selectedOption.notifyListeners();
                  }
                  selectedDate.value = DateFormat('d MMM yyyy').format(value);
                },
              ),
            ),
            Flexible(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(
                  height: 1,
                  color: Colors.grey.shade300,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 15, right: 15, bottom: 10),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 2,
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_today_rounded,
                              color: kprimaryColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ValueListenableBuilder(
                              valueListenable: selectedDate,
                              builder: (context, value, child) =>
                                  Text(selectedDate.value ?? "No Date"),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            EmpButton(
                              color: ksecondaryColor,
                              title: "Cancel",
                              foregroundColor: kprimaryColor,
                              onPressed: () {
                                widget.onValueSelected("No Date");
                                Navigator.of(context).pop();
                              },
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            EmpButton(
                              color: kprimaryColor,
                              title: "Save",
                              foregroundColor: ksecondaryColor,
                              onPressed: () {
                                widget.onValueSelected(selectedDate.value);
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }

  String getCurrentDay(DateTime value) {
    String currentDay = DateFormat('EEEE').format(value);
    return currentDay;
  }

  Map<String, dynamic> setDateList(DateTime value) {
    final Map<String, dynamic> selectedDays = {};
    for (int i = 0; i <= 3; i++) {
      switch (i) {
        case 0:
          selectedDays["Today"] = DateTime.now();
          break;
        case 1:
          final currentDayPlus1 =
              DateTime(value.year, value.month, (value.day + 1));
          selectedDays["Next ${getCurrentDay(currentDayPlus1)}"] =
              currentDayPlus1;
        case 2:
          final currentDayPlus2 =
              DateTime(value.year, value.month, (value.day + 2));
          selectedDays["Next ${getCurrentDay(currentDayPlus2)}"] =
              currentDayPlus2;

        case 3:
          final dayAfterWeek =
              DateTime(value.year, value.month, (value.day + 7));

          selectedDays["After 1 Week"] = dayAfterWeek;

        default:
      }
    }
    return selectedDays;
  }
}
