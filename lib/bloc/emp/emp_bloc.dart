import 'package:assignment_2/bloc/emp/emp_event.dart';
import 'package:assignment_2/bloc/emp/emp_state.dart';
import 'package:assignment_2/data/local/local_data_source.dart';
import 'package:assignment_2/model/employee.dart';
import 'package:bloc/bloc.dart';

class EmpBloc extends Bloc<EmpEvent, EmpState> {
  final LocalDataSource localDataSource;

  final List<Employee> employeeList = [];
  EmpBloc({required this.localDataSource}) : super(const EmpState()) {
    on<AddEmpEvent>(_addEmpEvent);
    on<RemoveEmpEvent>(_removeEmpEvent);
    on<EditEmpEvent>(_editEmpEvent);
  }

  void _addEmpEvent(AddEmpEvent event, Emitter<EmpState> emit) async {
    employeeList.clear();
    emit(EmpLoadingState());
    await localDataSource.insertEmployee(event.employee);
    employeeList.addAll(await localDataSource.getEmployees());
    emit(state.copyWith(employeeList: List.from(employeeList)));
  }

  void _removeEmpEvent(RemoveEmpEvent event, Emitter<EmpState> emit) async {
    employeeList.clear();
    await localDataSource.removeEmployee(event.employee);
    employeeList.addAll(await localDataSource.getEmployees());
    emit(EmpLoadingState());
    emit(state.copyWith(employeeList: List.from(employeeList)));
  }

  void _editEmpEvent(EditEmpEvent event, Emitter<EmpState> emit) async {
    employeeList.clear();
    emit(EmpLoadingState());
    await localDataSource.updateEmployee(event.employee);
    employeeList.addAll(await localDataSource.getEmployees());
    emit(state.copyWith(employeeList: List.from(employeeList)));
  }
}
