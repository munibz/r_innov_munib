// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../bloc/emp/emp_bloc.dart';
import '../../bloc/emp/emp_event.dart';
import '../../bloc/emp/emp_state.dart';
import '../../model/employee.dart';
import '../add/add_edit_employee.dart';
import '../components/emp_footer.dart';
import '../components/employee_tile.dart';
import '../components/status_sticky_header.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({super.key, required this.title});

  final String title;

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  @override
  void initState() {
    super.initState();
    context.read<EmpBloc>().add(InitEmpEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: Text(widget.title),
      ),
      body: BlocBuilder<EmpBloc, EmpState>(
        buildWhen: (previous, current) => current is! EmpLoadingState,
        builder: (context, state) {
          if (state is EmpLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (state.employeeList.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/images/no_employee.png'),
                    const Text(
                      "No Employee Records Found",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              );
            } else {
              return CustomScrollView(
                slivers: [
                  if (state.employeeList
                      .any((element) => element.toDate == null))
                    const StickyHeader(title: "Current Employees"),
                  SliverList.list(
                      children: state.employeeList
                          .where((element) => element.toDate == null)
                          .map(
                            (e) => EmployeeTile(
                              name: e.name!,
                              designation: e.designation!,
                              fromDate: e.fromDate!,
                              toDate: e.toDate,
                              dismissKey: UniqueKey(),
                              onEdit: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddEditEmployee(
                                      isEdit: true,
                                      employee: e,
                                    ),
                                  ),
                                );
                              },
                              onDismissed: (direction) {
                                context.read<EmpBloc>().add(RemoveEmpEvent(e));
                                showSnackBar(
                                    context, "Employee Data Was Deleted", () {
                                  context.read<EmpBloc>().add(AddEmpEvent(e));
                                });
                              },
                            ),
                          )
                          .toList()),
                  if (state.employeeList
                      .any((element) => element.toDate != null))
                    const StickyHeader(title: "Previous Employes"),
                  SliverList.list(
                      children: state.employeeList
                          .where((element) => element.toDate != null)
                          .map(
                            (e) => EmployeeTile(
                              name: e.name!,
                              designation: e.designation!,
                              fromDate: e.fromDate!,
                              toDate: e.toDate,
                              dismissKey: UniqueKey(),
                              onEdit: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddEditEmployee(
                                      isEdit: true,
                                      employee: e,
                                    ),
                                  ),
                                );
                              },
                              onDismissed: (direction) {
                                context.read<EmpBloc>().add(RemoveEmpEvent(e));
                                showSnackBar(
                                    context, "Employee Data Was Deleted", () {
                                  context.read<EmpBloc>().add(AddEmpEvent(e));
                                });
                              },
                            ),
                          )
                          .toList()),
                  const EndFooter(
                    title: "Swipe Left To Delete",
                  )
                ],
              );
            }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        elevation: 1,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditEmployee(
                isEdit: false,
              ),
            ),
          );
        },
        tooltip: 'Add Employee',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

void showSnackBar(
    BuildContext context, String title, void Function() onPressed) {
  final scaffoldMessenger = ScaffoldMessenger.of(context);

  // Create a SnackBar
  final snackBar = SnackBar(
    content: Text(title),
    duration: const Duration(seconds: 2),
    action: SnackBarAction(label: 'Undo', onPressed: onPressed),
  );
  scaffoldMessenger.showSnackBar(snackBar);
}
