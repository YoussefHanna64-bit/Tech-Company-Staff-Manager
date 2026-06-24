import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staff_manager/core/constants/app_icons.dart';
import 'package:staff_manager/core/widgets/custom_app_bar.dart';
import 'package:staff_manager/features/employee/domain/entities/employee.dart';
import 'package:staff_manager/features/employee/presentation/cubit/employee_cubit.dart';
import 'package:staff_manager/features/employee/presentation/cubit/employee_state.dart';
import 'package:staff_manager/features/employee/presentation/pages/employee_form_page.dart';
import 'package:staff_manager/features/employee/presentation/pages/widgets/delete_employee_dialog.dart';
import 'package:staff_manager/features/employee/presentation/pages/widgets/employee_empty_state.dart';
import 'package:staff_manager/features/employee/presentation/pages/widgets/employee_error_state.dart';
import 'package:staff_manager/features/employee/presentation/pages/widgets/employee_filter_panel.dart';
import 'package:staff_manager/features/employee/presentation/pages/widgets/employee_header_card.dart';
import 'package:staff_manager/features/employee/presentation/pages/widgets/employee_list_tile.dart';
import 'package:staff_manager/features/employee/presentation/pages/widgets/sort_bottom_sheet.dart';

class EmployeesPage extends StatefulWidget {
  const EmployeesPage({super.key});

  @override
  State<EmployeesPage> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = "";
  EmployeeDepartment? _selectedDepartment;
  bool _showFavoritesOnly = false;
  SortBy _sortBy = SortBy.name;

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
    return EmployeeCubit.filterAndSortEmployees(
      employees: employees,
      searchQuery: _searchQuery,
      selectedDepartment: _selectedDepartment,
      showFavoritesOnly: _showFavoritesOnly,
      sortBy: _sortBy,
    );
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

  Future<void> _confirmDelete(Employee employee) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => DeleteEmployeeDialog(
        employee: employee,
      ),
    );

    if (confirmed == true && mounted) {
      context.read<EmployeeCubit>().deleteEmployee(employee.id);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${employee.fullName} deleted'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Employees",
        actions: [
          IconButton(
            icon: const Icon(AppIcons.sort),
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
            final totalCount = state.employees.length;
            final favoritesCount =
                state.employees.where((e) => e.isFavorite).length;

            return RefreshIndicator(
              onRefresh: () async {
                await context.read<EmployeeCubit>().loadEmployees();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    EmployeeHeaderCard(
                      totalEmployees: totalCount,
                      favoriteEmployees: favoritesCount,
                    ),
                    const SizedBox(height: 12),
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
                                  onTap: () => _openEditEmployeeForm(emp),
                                  onLongPress: () => _confirmDelete(emp),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddEmployeeForm,
        child: const Icon(AppIcons.add),
      ),
    );
  }
}
