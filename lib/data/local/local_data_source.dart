import 'package:assignment_2/data/data_source.dart';
import 'package:assignment_2/data/local/emp_database.dart';
import 'package:assignment_2/model/employee.dart';

class LocalDataSource implements DataSource {
  final EmpDatabase _empdatabase;

  LocalDataSource(this._empdatabase);

  @override
  Future<List<Employee>> getEmployees() async {
    return await _empdatabase.empDao.getEmployees();
  }

  @override
  Future<void> insertEmployee(Employee emp) async {
    return await _empdatabase.empDao.insertEmployee(emp);
  }

  @override
  Future<void> removeEmployee(Employee emp) async {
    return await _empdatabase.empDao.removeEmployee(emp);
  }

  @override
  Future<int?> updateEmployee(Employee emp) async {
    return await _empdatabase.empDao.updateEmployee(emp);
  }
}
