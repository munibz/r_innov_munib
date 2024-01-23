import 'package:assignment_2/bloc/emp/emp_bloc.dart';
import 'package:assignment_2/utils/const.dart';
import 'package:assignment_2/ui/employee_list/employee_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'di/get_it.dart' as getit;

import 'ui/add/add_edit_employee.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getit.init();
  await getit.s1.allReady();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => EmpBloc(localDataSource: getit.s1()),
        ),
      ],
      child: MaterialApp(
        title: 'Assignment 2',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: kprimaryColor, primary: kprimaryColor),
          useMaterial3: true,
        ),
        home: EmployeeList(title: 'Employee List'),
      ),
    );
  }
}
