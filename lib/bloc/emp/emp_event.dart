import 'package:assignment_2/model/employee.dart';
import 'package:equatable/equatable.dart';

abstract class EmpEvent extends Equatable {
  const EmpEvent();
}

class InitEmpEvent extends EmpEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class AddEmpEvent extends EmpEvent {
  final Employee employee;

  const AddEmpEvent(this.employee);

  @override
  List<Object?> get props => [employee];
}

class RemoveEmpEvent extends EmpEvent {
  final Employee employee;

  const RemoveEmpEvent(this.employee);
  @override
  List<Object?> get props => [employee];
}

class EditEmpEvent extends EmpEvent {
  final Employee employee;

  const EditEmpEvent(this.employee);
  @override
  List<Object?> get props => [employee];
}

class EmpAddButtonClickedNavigateEvent extends EmpEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
