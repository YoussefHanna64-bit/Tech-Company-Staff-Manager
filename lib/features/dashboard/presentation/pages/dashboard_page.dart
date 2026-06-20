import 'package:flutter/material.dart';
import 'package:staff_manager/core/theme/app_colors.dart';
import 'package:staff_manager/core/widgets/custom_app_bar.dart';
import 'package:staff_manager/features/dashboard/presentation/pages/widgets/company_overview_card%20.dart';
import 'package:staff_manager/features/dashboard/presentation/pages/widgets/recent_activity_section.dart';
import 'package:staff_manager/features/dashboard/presentation/pages/widgets/statistic_card.dart';

class DashboardPage extends StatelessWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;

  const DashboardPage(
      {super.key, required this.isDark, required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: "Dashboard", isDark: isDark, onThemeChanged: onThemeChanged),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CompanyOverviewCard(
                totalEmployees: 24,
                favoriteEmployees: 5,
                departments: 5,
                averageSalary: 18500,
              ),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.35,
                children: const [
                  StatisticCard(
                    title: "Employees",
                    value: "24",
                    icon: Icons.groups,
                    iconColor: AppColors.blueDark,
                    backgroundColor: AppColors.blueLight,
                  ),
                  StatisticCard(
                    title: "Favorites",
                    value: "5",
                    icon: Icons.favorite,
                    iconColor: AppColors.red,
                    backgroundColor: AppColors.redLight,
                  ),
                  StatisticCard(
                    title: "Departments",
                    value: "5",
                    icon: Icons.account_tree,
                    iconColor: AppColors.teal,
                    backgroundColor: AppColors.tealLight,
                  ),
                  StatisticCard(
                    title: "Avg Salary",
                    value: "18,500",
                    icon: Icons.payments,
                    iconColor: AppColors.green,
                    backgroundColor: AppColors.greenLight,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const RecentActivitySection(),
            ],
          ),
        ),
      ),
    );
  }
}
