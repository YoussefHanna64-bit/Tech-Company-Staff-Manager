import 'package:flutter/material.dart';
import 'package:staff_manager/core/constants/app_icons.dart';
import 'package:staff_manager/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:staff_manager/features/employee/presentation/pages/employees_page.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const DashboardPage(),
      const EmployeesPage(),
    ];

    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(AppIcons.dashboardOutlined),
            selectedIcon: Icon(AppIcons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(AppIcons.groupsOutlined),
            selectedIcon: Icon(AppIcons.groups),
            label: 'Employees',
          ),
        ],
      ),
    );
  }
}
