import 'package:staff_manager/features/employee/domain/entities/employee.dart';

class EmployeeModel extends Employee {
  const EmployeeModel({
    required super.id,
    required super.fullName,
    required super.jobTitle,
    required super.department,
    required super.salary,
    required super.isFavorite,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "fullName": fullName,
      "jobTitle": jobTitle,
      "department": department.name,
      "salary": salary,
      "isFavorite": isFavorite ? 1 : 0,
    };
  }

  factory EmployeeModel.fromMap(Map<String, dynamic> map) {
    bool parsedFavorite = false;
    final favorite = map["isFavorite"];

    if (favorite is bool) {
      parsedFavorite = favorite;
    } else if (favorite is int) {
      parsedFavorite = favorite == 1;
    } else if (favorite is String) {
      parsedFavorite = favorite.toLowerCase() == 'true';
    }

    final deptString = map["department"] as String?;
    final parsedDepartment = EmployeeDepartment.values.firstWhere(
      (e) => e.name == deptString,
      orElse: () => EmployeeDepartment.engineering,
    );

    return EmployeeModel(
      id: int.tryParse(map["id"].toString()) ?? 0,
      fullName: map["fullName"] as String? ?? 'Unknown',
      jobTitle: map["jobTitle"] as String? ?? 'Unknown Title',
      department: parsedDepartment,
      salary: double.tryParse(map["salary"].toString()) ?? 0.0,
      isFavorite: parsedFavorite,
    );
  }

  factory EmployeeModel.fromEntity(Employee entity) {
    return EmployeeModel(
      id: entity.id,
      fullName: entity.fullName,
      jobTitle: entity.jobTitle,
      department: entity.department,
      salary: entity.salary,
      isFavorite: entity.isFavorite,
    );
  }
}
