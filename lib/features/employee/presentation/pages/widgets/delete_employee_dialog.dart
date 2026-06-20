import 'package:flutter/material.dart';
import 'package:staff_manager/features/employee/domain/entities/employee.dart';

class DeleteEmployeeDialog extends StatelessWidget {
  final Employee employee;

  const DeleteEmployeeDialog({
    super.key,
    required this.employee,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete ${employee.fullName}?'),
      content: const Text("This action can't be undone."),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text("Cancel"),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Theme.of(context).colorScheme.onError,
          ),
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text("Delete"),
        ),
      ],
    );
  }
}
