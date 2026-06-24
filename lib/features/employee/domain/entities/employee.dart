enum EmployeeDepartment { engineering, design, hr, marketing, sales }

enum SortBy { name, salary, jobTitle }

extension EmployeeDepartmentExtension on EmployeeDepartment {
  String get label {
    switch (this) {
      case EmployeeDepartment.engineering:
        return "Engineering";
      case EmployeeDepartment.design:
        return "Design";
      case EmployeeDepartment.hr:
        return "HR";
      case EmployeeDepartment.marketing:
        return "Marketing";
      case EmployeeDepartment.sales:
        return "Sales";
    }
  }
}

class Employee {
  final int id;
  final String fullName;
  final String jobTitle;
  final EmployeeDepartment department;
  final double salary;
  final bool isFavorite;

  const Employee({
    required this.id,
    required this.fullName,
    required this.jobTitle,
    required this.department,
    required this.salary,
    required this.isFavorite,
  });

  Employee copyWith({
    int? id,
    String? fullName,
    String? jobTitle,
    EmployeeDepartment? department,
    double? salary,
    bool? isFavorite,
  }) {
    return Employee(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      jobTitle: jobTitle ?? this.jobTitle,
      department: department ?? this.department,
      salary: salary ?? this.salary,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
