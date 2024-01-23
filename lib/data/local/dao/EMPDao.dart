import 'package:assignment_2/model/employee.dart';
import 'package:floor/floor.dart';

@dao
abstract class EmpDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertEmployee(Employee emp);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<int?> updateEmployee(Employee emp);

  @delete
  Future<void> removeEmployee(Employee emp);

  @Query('SELECT * FROM employee')
  Future<List<Employee>> getEmployees();
}
