import 'package:flutter/material.dart';

class SortBottomSheet extends StatelessWidget {
  final String currentSort;
  final ValueChanged<String> onSelected;

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
            leading: const Icon(Icons.sort_by_alpha),
            title: const Text("Sort by Name"),
            selected: currentSort == "name",
            onTap: () {
              onSelected("name");
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.payments),
            title: const Text("Sort by Salary"),
            selected: currentSort == "salary",
            onTap: () {
              onSelected("salary");
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.business_center),
            title: const Text("Sort by Job Title"),
            selected: currentSort == "jobTitle",
            onTap: () {
              onSelected("jobTitle");
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
