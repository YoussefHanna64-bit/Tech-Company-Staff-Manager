import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staff_manager/core/widgets/custom_app_bar.dart';
import 'package:staff_manager/features/employee/domain/entities/employee.dart';
import 'package:staff_manager/features/employee/presentation/cubit/employee_cubit.dart';
import 'package:staff_manager/features/employee/presentation/cubit/employee_state.dart';
import 'package:staff_manager/features/employee/presentation/pages/employee_form_page.dart';
import 'package:staff_manager/features/employee/presentation/pages/widgets/employee_empty_state.dart';
import 'package:staff_manager/features/employee/presentation/pages/widgets/employee_error_state.dart';
import 'package:staff_manager/features/employee/presentation/pages/widgets/employee_filter_panel.dart';
import 'package:staff_manager/features/employee/presentation/pages/widgets/employee_list_tile.dart';
import 'package:staff_manager/features/employee/presentation/pages/widgets/sort_bottom_sheet.dart';

class EmployeesPage extends StatefulWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;

  const EmployeesPage({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
  });

  @override
  State<EmployeesPage> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = "";
  EmployeeDepartment? _selectedDepartment;
  bool _showFavoritesOnly = false;
  String _sortBy = "name";

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _clearFilters() {
    _searchController.clear();
    setState(() {
      _selectedDepartment = null;
      _showFavoritesOnly = false;
    });
  }

  void _showSortBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SortBottomSheet(
          currentSort: _sortBy,
          onSelected: (value) {
            setState(() {
              _sortBy = value;
            });
          },
        );
      },
    );
  }

  List<Employee> _getFilteredAndSortedEmployees(List<Employee> employees) {
    var filtered = employees.where((emp) {
      final matchesSearch =
          emp.fullName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              emp.jobTitle.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              emp.department.label
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase());

      final matchesDept =
          _selectedDepartment == null || emp.department == _selectedDepartment;

      final matchesFav = !_showFavoritesOnly || emp.isFavorite;

      return matchesSearch && matchesDept && matchesFav;
    }).toList();

    filtered.sort((a, b) {
      if (_sortBy == "salary") {
        return b.salary.compareTo(a.salary);
      } else if (_sortBy == "jobTitle") {
        return a.jobTitle.compareTo(b.jobTitle);
      }
      return a.fullName.compareTo(b.fullName);
    });

    return filtered;
  }

  Future<void> _openAddEmployeeForm() async {
    final newEmployee = await Navigator.of(context).push<Employee>(
      MaterialPageRoute(builder: (context) => const EmployeeFormPage()),
    );

    if (!mounted || newEmployee == null) {
      return;
    }

    context.read<EmployeeCubit>().addEmployee(newEmployee);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${newEmployee.fullName} added')),
    );
  }

  Future<void> _openEditEmployeeForm(Employee employee) async {
    final updatedEmployee = await Navigator.of(context).push<Employee>(
      MaterialPageRoute(
        builder: (context) => EmployeeFormPage(existingEmployee: employee),
      ),
    );

    if (!mounted || updatedEmployee == null) {
      return;
    }

    context.read<EmployeeCubit>().updateEmployee(updatedEmployee);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${updatedEmployee.fullName} updated')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Employees",
        isDark: widget.isDark,
        onThemeChanged: widget.onThemeChanged,
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: _showSortBottomSheet,
          ),
        ],
      ),
      body: BlocBuilder<EmployeeCubit, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeeLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is EmployeeError) {
            return EmployeeErrorState(
              message: state.message,
              onRetry: () => context.read<EmployeeCubit>().loadEmployees(),
            );
          }

          if (state is EmployeeLoaded) {
            final displayList = _getFilteredAndSortedEmployees(state.employees);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Card(
                    child: EmployeeFilterPanel(
                      searchController: _searchController,
                      selectedDepartment: _selectedDepartment,
                      showFavoritesOnly: _showFavoritesOnly,
                      onDepartmentSelected: (dept) {
                        setState(() {
                          _selectedDepartment = dept;
                        });
                      },
                      onFavoritesOnlyChanged: (value) {
                        setState(() {
                          _showFavoritesOnly = value;
                        });
                      },
                      onClearFilters: _clearFilters,
                    ),
                  ),
                  Expanded(
                    child: displayList.isEmpty
                        ? EmployeeEmptyState(onClearFilters: _clearFilters)
                        : ListView.builder(
                            itemCount: displayList.length,
                            itemBuilder: (context, index) {
                              final emp = displayList[index];
                              return EmployeeListTile(
                                  employee: emp,
                                  onFavoritePressed: () {
                                    context
                                        .read<EmployeeCubit>()
                                        .toggleFavorite(emp);
                                  },
                                  onTap: () => _openEditEmployeeForm(emp));
                            },
                          ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddEmployeeForm,
        child: const Icon(Icons.add),
      ),
    );
  }
}
