import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:staff_manager/core/constants/app_icons.dart';
import 'package:staff_manager/core/theme/app_colors.dart';
import 'package:staff_manager/core/widgets/custom_app_bar.dart';
import 'package:staff_manager/features/dashboard/presentation/pages/widgets/company_overview_card.dart';
import 'package:staff_manager/features/dashboard/presentation/pages/widgets/recent_activity_section.dart';
import 'package:staff_manager/features/dashboard/presentation/pages/widgets/statistic_card.dart';
import 'package:staff_manager/features/employee/presentation/cubit/employee_cubit.dart';
import 'package:staff_manager/features/employee/presentation/cubit/employee_state.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat('#,##0', 'en_US');

    return Scaffold(
      appBar: CustomAppBar(title: "Dashboard"),
      body: SafeArea(
        child: BlocBuilder<EmployeeCubit, EmployeeState>(
          builder: (context, state) {
            int totalEmployees = 0;
            int favorites = 0;
            int departments = 0;
            double avgSalary = 0;

            if (state is EmployeeLoaded && state.employees.isNotEmpty) {
              totalEmployees = state.employees.length;
              favorites = state.employees.where((e) => e.isFavorite).length;
              departments =
                  state.employees.map((e) => e.department).toSet().length;

              final totalSalary =
                  state.employees.fold(0.0, (sum, e) => sum + e.salary);
              avgSalary = totalSalary / totalEmployees;
            }

            final formattedSalary = currencyFormat.format(avgSalary);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CompanyOverviewCard(
                    totalEmployees: totalEmployees,
                    favoriteEmployees: favorites,
                    departments: departments,
                    averageSalary: avgSalary,
                  ),
                  const SizedBox(height: 12),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.35,
                    children: [
                      StatisticCard(
                        title: "Employees",
                        value: "$totalEmployees",
                        icon: AppIcons.groups,
                        iconColor: AppColors.blueDark,
                        backgroundColor: AppColors.blueLight,
                      ),
                      StatisticCard(
                        title: "Favorites",
                        value: "$favorites",
                        icon: AppIcons.favorite,
                        iconColor: AppColors.red,
                        backgroundColor: AppColors.redLight,
                      ),
                      StatisticCard(
                        title: "Departments",
                        value: "$departments",
                        icon: AppIcons.accountTree,
                        iconColor: AppColors.teal,
                        backgroundColor: AppColors.tealLight,
                      ),
                      StatisticCard(
                        title: "Avg Salary",
                        value: formattedSalary,
                        icon: AppIcons.payments,
                        iconColor: AppColors.green,
                        backgroundColor: AppColors.greenLight,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const RecentActivitySection(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
