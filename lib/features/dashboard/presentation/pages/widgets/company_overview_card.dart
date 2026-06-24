import 'package:flutter/material.dart';
import 'package:staff_manager/core/constants/app_icons.dart';
import 'package:staff_manager/core/theme/app_colors.dart';
import 'package:staff_manager/features/dashboard/presentation/pages/widgets/info_row.dart';

class CompanyOverviewCard extends StatelessWidget {
  final int totalEmployees;
  final int favoriteEmployees;
  final int departments;
  final double averageSalary;
  const CompanyOverviewCard(
      {super.key,
      required this.totalEmployees,
      required this.favoriteEmployees,
      required this.departments,
      required this.averageSalary});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: AppColors.primary,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Icon(
                AppIcons.corporateFare,
                size: 90,
                color: AppColors.whiteColor.withValues(alpha: .9),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Company Overview",
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "HR summary and employee insights",
                  style: TextStyle(
                    color: AppColors.whiteColor.withValues(alpha: .9),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 24),
                InfoRow(
                  icon: AppIcons.groups,
                  text: "Total Employees: $totalEmployees",
                ),
                const SizedBox(height: 12),
                InfoRow(
                  icon: AppIcons.favorite,
                  text: "Favorite Employees: $favoriteEmployees",
                ),
                const SizedBox(height: 12),
                InfoRow(
                  icon: AppIcons.accountTree,
                  text: "Departments: $departments",
                ),
                const SizedBox(height: 12),
                InfoRow(
                  icon: AppIcons.payments,
                  text:
                      "Average Salary: ${averageSalary.toStringAsFixed(0)} EGP",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
