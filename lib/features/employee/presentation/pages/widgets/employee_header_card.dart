import 'package:flutter/material.dart';
import 'package:staff_manager/core/constants/app_icons.dart';

class EmployeeHeaderCard extends StatelessWidget {
  final int totalEmployees;
  final int favoriteEmployees;

  const EmployeeHeaderCard({
    super.key,
    required this.totalEmployees,
    required this.favoriteEmployees,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(
              AppIcons.groupsOutlined,
              size: 40,
              color: colorScheme.primary,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Technology Company Employees",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "$totalEmployees employees available • $favoriteEmployees favorites",
                    style: TextStyle(color: colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
