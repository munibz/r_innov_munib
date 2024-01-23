import 'package:assignment_2/bloc/emp/emp_bloc.dart';
import 'package:assignment_2/data/local/emp_database.dart';
import 'package:assignment_2/data/local/local_data_source.dart';
import 'package:get_it/get_it.dart';

var s1 = GetIt.instance;

Future init() async {
  final empdatabase =
      await $FloorEmpDatabase.databaseBuilder('emp_database.db').build();
  s1.registerSingleton<EmpDatabase>(empdatabase);
  s1.registerLazySingleton<LocalDataSource>(() => LocalDataSource(empdatabase));

  s1.registerFactory(() => EmpBloc(localDataSource: s1.get<LocalDataSource>()));
}
