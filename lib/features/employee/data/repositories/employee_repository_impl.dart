import 'package:staff_manager/features/employee/data/datasources/employee_local_data_source.dart';
import 'package:staff_manager/features/employee/data/datasources/employee_remote_data_source.dart';
import 'package:staff_manager/features/employee/domain/entities/employee.dart';
import 'package:staff_manager/features/employee/domain/repositories/employee_repository.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeeLocalDataSource localDataSource;
  final EmployeeRemoteDataSource remoteDataSource;

  EmployeeRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<List<Employee>> getEmployees() async {
    try {
      final apiEmployees = await remoteDataSource.getEmployees();

      for (final employee in apiEmployees) {
        await localDataSource.insertEmployee(employee);
      }

      return await localDataSource.getEmployees();
    } catch (e) {
      final localData = await localDataSource.getEmployees();
      if (localData.isNotEmpty) {
        return localData;
      }
      throw Exception("No Internet and no local employee data found");
    }
  }

  @override
  Future<void> addEmployee(Employee employee) async {
    final newEmployee = await remoteDataSource.insertEmployee(employee);
    await localDataSource.insertEmployee(newEmployee);
  }

  @override
  Future<void> updateEmployee(Employee employee) async {
    await remoteDataSource.updateEmployee(employee);
    await localDataSource.updateEmployee(employee);
  }

  @override
  Future<void> deleteEmployee(int id) async {
    await remoteDataSource.deleteEmployee(id);
    await localDataSource.deleteEmployee(id);
  }

  @override
  Future<void> toggleFavorite(Employee employee) async {
    final updatedEmployee = employee.copyWith(isFavorite: !employee.isFavorite);
    await updateEmployee(updatedEmployee);
  }
}
