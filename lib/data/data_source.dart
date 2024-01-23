import 'package:assignment_2/model/employee.dart';

abstract class DataSource {
  Future<List<Employee>> getEmployees();

  Future<void> insertEmployee(Employee emp);

  Future<void> removeEmployee(Employee emp);

  Future<void> updateEmployee(Employee emp);

}