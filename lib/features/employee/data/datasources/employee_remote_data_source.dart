import 'package:staff_manager/core/network/dio_client.dart';
import 'package:staff_manager/core/network/end_points.dart';
import 'package:staff_manager/features/employee/data/models/employee_model.dart';
import 'package:staff_manager/features/employee/domain/entities/employee.dart';

class EmployeeRemoteDataSource {
  final DioClient _dioClient;

  EmployeeRemoteDataSource({required DioClient dioClient})
      : _dioClient = dioClient;

  Future<List<Employee>> getEmployees() async {
    final response = await _dioClient.dio.get(EndPoints.employees);
    final List<dynamic> data = response.data;

    return data
        .map((json) => EmployeeModel.fromMap(json as Map<String, dynamic>))
        .toList();
  }

  Future<Employee> insertEmployee(Employee employee) async {
    final model = EmployeeModel.fromEntity(employee);
    final employeeMap = model.toMap();

    if (employeeMap["id"] == 0) {
      employeeMap.remove("id");
    }

    final response =
        await _dioClient.dio.post(EndPoints.employees, data: employeeMap);
    return EmployeeModel.fromMap(response.data as Map<String, dynamic>);
  }

  Future<void> updateEmployee(Employee employee) async {
    final model = EmployeeModel.fromEntity(employee);
    await _dioClient.dio
        .put("${EndPoints.employees}/${employee.id}", data: model.toMap());
  }

  Future<void> deleteEmployee(int id) async {
    await _dioClient.dio.delete("${EndPoints.employees}/$id");
  }
}
