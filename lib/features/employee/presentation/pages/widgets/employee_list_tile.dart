import 'package:flutter/material.dart';
import 'package:staff_manager/core/theme/app_colors.dart';
import 'package:staff_manager/features/employee/domain/entities/employee.dart';

class EmployeeListTile extends StatelessWidget {
  final Employee employee;
  final VoidCallback onFavoritePressed;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const EmployeeListTile(
      {super.key,
      required this.employee,
      required this.onFavoritePressed,
      required this.onTap,
      required this.onLongPress});

  @override
  Widget build(BuildContext context) {
    Color _getDepartmentColor() {
      switch (employee.department) {
        case EmployeeDepartment.engineering:
          return AppColors.primary;
        case EmployeeDepartment.design:
          return AppColors.green;
        case EmployeeDepartment.hr:
          return AppColors.red;
        case EmployeeDepartment.marketing:
          return AppColors.teal;
        case EmployeeDepartment.sales:
          return AppColors.greyColor;
      }
    }

    return Card(
      child: ListTile(
        onTap: onTap,
        onLongPress: onLongPress,
        leading: CircleAvatar(
          backgroundColor: _getDepartmentColor().withAlpha(30),
          foregroundColor: _getDepartmentColor(),
          child: Text(
            employee.fullName[0].toUpperCase(),
          ),
        ),
        title: Text(employee.fullName),
        subtitle: Text(
          "${employee.jobTitle} • ${employee.department.label}\nSalary: ${employee.salary} EGP",
        ),
        trailing: IconButton(
          icon: Icon(
            employee.isFavorite ? Icons.favorite : Icons.favorite_border,
            color: employee.isFavorite ? Colors.amber : null,
          ),
          onPressed: onFavoritePressed,
        ),
      ),
    );
  }
}
