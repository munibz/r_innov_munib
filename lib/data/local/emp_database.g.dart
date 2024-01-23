// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emp_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorEmpDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$EmpDatabaseBuilder databaseBuilder(String name) =>
      _$EmpDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$EmpDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$EmpDatabaseBuilder(null);
}

class _$EmpDatabaseBuilder {
  _$EmpDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$EmpDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$EmpDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<EmpDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$EmpDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$EmpDatabase extends EmpDatabase {
  _$EmpDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  EmpDao? _empDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `employee` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `designation` TEXT, `fromDate` TEXT, `toDate` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  EmpDao get empDao {
    return _empDaoInstance ??= _$EmpDao(database, changeListener);
  }
}

class _$EmpDao extends EmpDao {
  _$EmpDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _employeeInsertionAdapter = InsertionAdapter(
            database,
            'employee',
            (Employee item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'designation': item.designation,
                  'fromDate': item.fromDate,
                  'toDate': item.toDate
                }),
        _employeeUpdateAdapter = UpdateAdapter(
            database,
            'employee',
            ['id'],
            (Employee item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'designation': item.designation,
                  'fromDate': item.fromDate,
                  'toDate': item.toDate
                }),
        _employeeDeletionAdapter = DeletionAdapter(
            database,
            'employee',
            ['id'],
            (Employee item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'designation': item.designation,
                  'fromDate': item.fromDate,
                  'toDate': item.toDate
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Employee> _employeeInsertionAdapter;

  final UpdateAdapter<Employee> _employeeUpdateAdapter;

  final DeletionAdapter<Employee> _employeeDeletionAdapter;

  @override
  Future<List<Employee>> getEmployees() async {
    return _queryAdapter.queryList('SELECT * FROM employee',
        mapper: (Map<String, Object?> row) => Employee(
            id: row['id'] as int?,
            name: row['name'] as String?,
            designation: row['designation'] as String?,
            fromDate: row['fromDate'] as String?,
            toDate: row['toDate'] as String?));
  }

  @override
  Future<void> insertEmployee(Employee emp) async {
    await _employeeInsertionAdapter.insert(emp, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateEmployee(Employee emp) {
    return _employeeUpdateAdapter.updateAndReturnChangedRows(
        emp, OnConflictStrategy.replace);
  }

  @override
  Future<void> removeEmployee(Employee emp) async {
    await _employeeDeletionAdapter.delete(emp);
  }
}
