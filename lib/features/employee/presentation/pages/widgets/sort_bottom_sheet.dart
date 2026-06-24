import 'package:flutter/material.dart';
import 'package:staff_manager/core/constants/app_icons.dart';
import 'package:staff_manager/features/employee/domain/entities/employee.dart';

class SortBottomSheet extends StatelessWidget {
  final SortBy currentSort;
  final ValueChanged<SortBy> onSelected;

  const SortBottomSheet({
    super.key,
    required this.currentSort,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(AppIcons.sortByAlpha),
            title: const Text("Sort by Name"),
            selected: currentSort == SortBy.name,
            onTap: () {
              onSelected(SortBy.name);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(AppIcons.payments),
            title: const Text("Sort by Salary"),
            selected: currentSort == SortBy.salary,
            onTap: () {
              onSelected(SortBy.salary);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(AppIcons.businessCenter),
            title: const Text("Sort by Job Title"),
            selected: currentSort == SortBy.jobTitle,
            onTap: () {
              onSelected(SortBy.jobTitle);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
