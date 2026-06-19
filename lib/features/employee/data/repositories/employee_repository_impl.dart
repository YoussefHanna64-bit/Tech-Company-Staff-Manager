import 'package:staff_manager/features/employee/data/datasources/employee_local_data_source.dart';
import 'package:staff_manager/features/employee/domain/entities/employee.dart';
import 'package:staff_manager/features/employee/domain/repositories/employee_repository.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeeLocalDataSource localDataSource;

  EmployeeRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<List<Employee>> getEmployees() async {
    return await localDataSource.getEmployees();
  }

  @override
  Future<void> addEmployee(Employee employee) async {
    await localDataSource.insertEmployee(employee);
  }

  @override
  Future<void> updateEmployee(Employee employee) async {
    await localDataSource.updateEmployee(employee);
  }

  @override
  Future<void> deleteEmployee(int id) async {
    await localDataSource.deleteEmployee(id);
  }

  @override
  Future<void> toggleFavorite(Employee employee) async {
    final updatedEmployee = employee.copyWith(isFavorite: !employee.isFavorite);
    await updateEmployee(updatedEmployee);
  }
}
