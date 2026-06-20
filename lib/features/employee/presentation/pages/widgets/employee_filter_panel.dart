import 'package:flutter/material.dart';
import 'package:staff_manager/core/widgets/custom_text_form_field.dart';
import 'package:staff_manager/features/employee/domain/entities/employee.dart';

class EmployeeFilterPanel extends StatelessWidget {
  const EmployeeFilterPanel({
    super.key,
    required this.searchController,
    required this.selectedDepartment,
    required this.showFavoritesOnly,
    required this.onDepartmentSelected,
    required this.onFavoritesOnlyChanged,
    required this.onClearFilters,
  });

  final TextEditingController searchController;
  final EmployeeDepartment? selectedDepartment;
  final bool showFavoritesOnly;

  final ValueChanged<EmployeeDepartment?> onDepartmentSelected;
  final ValueChanged<bool> onFavoritesOnlyChanged;
  final VoidCallback onClearFilters;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          controller: searchController,
          labelText: "Search Employees",
          hintText: "Search by name, job title, or department",
          icon: Icons.search,
          validator: (value) => null,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: [
            FilterChip(
              label: const Text("Engineering"),
              selected: selectedDepartment == EmployeeDepartment.engineering,
              onSelected: (_) {
                if (selectedDepartment == EmployeeDepartment.engineering) {
                  onDepartmentSelected(null);
                } else {
                  onDepartmentSelected(EmployeeDepartment.engineering);
                }
              },
            ),
            FilterChip(
                label: const Text("Design"),
                selected: selectedDepartment == EmployeeDepartment.design,
                onSelected: (_) {
                  if (selectedDepartment == EmployeeDepartment.design) {
                    onDepartmentSelected(null);
                  } else {
                    onDepartmentSelected(EmployeeDepartment.design);
                  }
                }),
            FilterChip(
              label: const Text("HR"),
              selected: selectedDepartment == EmployeeDepartment.hr,
              onSelected: (_) {
                if (selectedDepartment == EmployeeDepartment.hr) {
                  onDepartmentSelected(null);
                } else {
                  onDepartmentSelected(EmployeeDepartment.hr);
                }
              },
            ),
            FilterChip(
              label: const Text("Marketing"),
              selected: selectedDepartment == EmployeeDepartment.marketing,
              onSelected: (_) {
                if (selectedDepartment == EmployeeDepartment.marketing) {
                  onDepartmentSelected(null);
                } else {
                  onDepartmentSelected(EmployeeDepartment.marketing);
                }
              },
            ),
            FilterChip(
              label: const Text("Sales"),
              selected: selectedDepartment == EmployeeDepartment.sales,
              onSelected: (_) {
                if (selectedDepartment == EmployeeDepartment.sales) {
                  onDepartmentSelected(null);
                } else {
                  onDepartmentSelected(EmployeeDepartment.sales);
                }
              },
            ),
          ],
        ),
        SwitchListTile(
          title: const Text("Show Favorites Only"),
          secondary: const Icon(
            Icons.favorite_border,
          ),
          value: showFavoritesOnly,
          onChanged: onFavoritesOnlyChanged,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: onClearFilters,
            icon: const Icon(Icons.clear),
            label: const Text("Clear Filters"),
          ),
        ),
        const Divider(thickness: 2),
      ],
    );
  }
}
