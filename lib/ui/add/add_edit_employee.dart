import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/emp/emp_bloc.dart';
import '../../bloc/emp/emp_event.dart';
import '../../model/employee.dart';
import '../../utils/const.dart';
import '../../utils/validation.dart';
import '../components/emp_bottomsheet_row.dart';
import '../components/emp_button.dart';
import '../components/emp_calendar.dart';
import '../components/emp_text_form_field.dart';

class AddEditEmployee extends StatefulWidget {
  final bool isEdit;
  final Employee? employee;

  const AddEditEmployee({super.key, required this.isEdit, this.employee});

  @override
  State<AddEditEmployee> createState() => _AddEditEmployeeState();
}

class _AddEditEmployeeState extends State<AddEditEmployee>
    with ValidationMixin {
  final List<String> designation = [
    "Flutter Developer",
    "Product Designer",
    "QA Tester",
    "Product Owner"
  ];

  late final TextEditingController roleController = TextEditingController();
  late final TextEditingController fromDate = TextEditingController();
  late final TextEditingController toDate = TextEditingController();
  late final GlobalKey<FormState> _formKey = GlobalKey();

  Employee addEmployee = Employee();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      roleController.text = widget.employee?.designation ?? "";
      fromDate.text = widget.employee?.fromDate ?? "";
      toDate.text = widget.employee?.toDate ?? "";
    }
  }

  @override
  void dispose() {
    super.dispose();
    roleController.dispose();
    fromDate.dispose();
    toDate.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: Text(!widget.isEdit ? "Add Employee" : "Edit Employee Details"),
        actions: widget.isEdit
            ? [
                IconButton(
                    onPressed: () {
                      context
                          .read<EmpBloc>()
                          .add(RemoveEmpEvent(widget.employee!));
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.delete_outline))
              ]
            : null,
      ),
      body: Padding(
        padding: EdgeInsets.only(
            top: 20, bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Wrap(
                      runSpacing: 20,
                      children: <Widget>[
                        EmpTextField(
                          initialValue:
                              widget.isEdit ? widget.employee?.name : null,
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: kprimaryColor,
                          ),
                          validator: (value) =>
                              validateNullEmpty("Name", value),
                          hint: "Employee Name",
                          onSaved: (savedValue) => widget.isEdit
                              ? widget.employee?.name = savedValue
                              : addEmployee.name = savedValue,
                        ),
                        EmpTextField(
                          prefixIcon: Icon(
                            Icons.work_outline,
                            color: kprimaryColor,
                          ),
                          suffixIcon: Icon(
                            Icons.arrow_drop_down_rounded,
                            color: kprimaryColor,
                            size: 32,
                          ),
                          controller: roleController,
                          showCursor: false,
                          readOnly: true,
                          onTap: () => _showBottomSheet(context),
                          validator: (value) =>
                              validateNullEmpty("Role", value),
                          hint: "Select Role",
                          onSaved: (savedValue) => widget.isEdit
                              ? widget.employee?.designation = savedValue
                              : addEmployee.designation = savedValue,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: EmpTextField(
                                controller: fromDate,
                                prefixIcon: Icon(
                                  Icons.calendar_today,
                                  color: kprimaryColor,
                                ),
                                validator: (value) =>
                                    validateNullEmpty("From Date", value),
                                hint: "No Date",
                                showCursor: false,
                                readOnly: true,
                                onTap: () => _showCalendar(context, fromDate),
                                onSaved: (savedValue) => widget.isEdit
                                    ? widget.employee?.fromDate = savedValue
                                    : addEmployee.fromDate = savedValue,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Icon(
                                    Icons.arrow_forward_rounded,
                                    color: kprimaryColor,
                                  )),
                            ),
                            Expanded(
                              flex: 2,
                              child: EmpTextField(
                                  controller: toDate,
                                  showCursor: false,
                                  readOnly: true,
                                  prefixIcon: Icon(
                                    Icons.calendar_today,
                                    color: kprimaryColor,
                                  ),
                                  hint: "No Date",
                                  onTap: () => _showCalendar(context, toDate),
                                  onSaved: (savedValue) {
                                    if (savedValue == "") {
                                      widget.isEdit
                                          ? widget.employee?.toDate = null
                                          : addEmployee.toDate = null;
                                      return;
                                    }
                                    widget.isEdit
                                        ? widget.employee?.toDate = savedValue
                                        : addEmployee.toDate = savedValue;
                                  }),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Divider(
                  height: 1,
                  color: Colors.grey.shade400,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      EmpButton(
                        color: Color(0xffEDF8FF),
                        title: "Cancel",
                        onPressed: () => Navigator.of(context).pop(),
                        foregroundColor: Color(0xff1DA1F2),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      EmpButton(
                        color: Color(0xff1DA1F2),
                        title: "Save",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState?.save();

                            context.read<EmpBloc>().add(
                                  widget.isEdit
                                      ? EditEmpEvent(widget.employee!)
                                      : AddEmpEvent(addEmployee),
                                );
                            Navigator.of(context).pop();
                          }
                        },
                        foregroundColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  void _showBottomSheet(BuildContext context) {
    scheduleMicrotask(() {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: designation.length,
                itemBuilder: (context, index) {
                  return EmpRow(
                    title: designation[index],
                    onTap: () {
                      roleController.text = designation[index];
                      Navigator.of(context).pop();
                    },
                  );
                },
              ));
        },
      );
    });
  }

  void _showCalendar(BuildContext context, TextEditingController controller) {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: EmpCalendar(
          onValueSelected: (selectedValue) {
            controller.text = selectedValue ?? "";
          },
        ),
      ),
    );
  }
}
