import 'package:flutter/material.dart';
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
    return Card(
      child: ListTile(
        onTap: onTap,
        onLongPress: onLongPress,
        leading: CircleAvatar(
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
