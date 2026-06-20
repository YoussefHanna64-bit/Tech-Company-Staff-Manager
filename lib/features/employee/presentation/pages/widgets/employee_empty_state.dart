import 'package:flutter/material.dart';
import 'package:staff_manager/core/theme/app_text_styles.dart';

class EmployeeEmptyState extends StatelessWidget {
  final VoidCallback onClearFilters;

  const EmployeeEmptyState({
    super.key,
    required this.onClearFilters,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.people_outline,
              size: 72,
              color: colorScheme.primary,
            ),
            const SizedBox(height: 16),
            const Text("No matching employees found",
                style: AppTextStyles.medium16Dark),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                iconColor: colorScheme.onPrimary,
              ),
              onPressed: onClearFilters,
              icon: const Icon(Icons.clear),
              label: const Text("Clear Filters"),
            ),
          ],
        ),
      ),
    );
  }
}
