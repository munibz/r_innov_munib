
import 'dart:async';

import 'package:assignment_2/data/local/dao/EMPDao.dart';
import 'package:assignment_2/model/employee.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'emp_database.g.dart';

@Database(version: 1, entities: [Employee])
abstract class EmpDatabase extends FloorDatabase {
  EmpDao get empDao;
}
