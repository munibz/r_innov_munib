import 'package:assignment_2/model/employee.dart';
import 'package:equatable/equatable.dart';

class EmpState extends Equatable {
  final List<Employee> employeeList;
  const EmpState({this.employeeList = const []});

  @override
  List<Object?> get props => [employeeList];

  EmpState copyWith({List<Employee>? employeeList}) {
    return EmpState(employeeList: employeeList ?? this.employeeList);
  }
}

class EmpLoadingState extends EmpState {}
