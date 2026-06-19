import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:staff_manager/features/employee/data/models/employee_model.dart';
import 'package:staff_manager/features/employee/domain/entities/employee.dart';

class EmployeeLocalDataSource {
  static final EmployeeLocalDataSource instance =
      EmployeeLocalDataSource._init();
  static Database? _database;

  EmployeeLocalDataSource._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB("employees.db");
    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, filepath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE employees(
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        fullName TEXT NOT NULL, 
        jobTitle TEXT NOT NULL, 
        department TEXT NOT NULL, 
        salary REAL NOT NULL, 
        isFavorite INTEGER NOT NULL
      )
    ''');
  }

  Future<int> insertEmployee(Employee employee) async {
    final db = await instance.database;
    final model = EmployeeModel.fromEntity(employee);
    final map = model.toMap();

    if (map["id"] == 0) {
      map.remove("id");
    }

    return await db.insert(
      "employees",
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Employee>> getEmployees() async {
    final db = await instance.database;
    final maps = await db.query("employees");

    return maps.map((map) => EmployeeModel.fromMap(map)).toList();
  }

  Future<int> updateEmployee(Employee employee) async {
    final db = await instance.database;
    final model = EmployeeModel.fromEntity(employee);

    return await db.update(
      "employees",
      model.toMap(),
      where: "id = ?",
      whereArgs: [employee.id],
    );
  }

  Future<int> deleteEmployee(int id) async {
    final db = await instance.database;

    return await db.delete(
      "employees",
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
