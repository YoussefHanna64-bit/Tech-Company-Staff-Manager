import 'package:flutter/material.dart';
import 'package:staff_manager/core/constants/app_icons.dart';
import 'package:staff_manager/core/theme/app_colors.dart';
import 'package:staff_manager/core/theme/app_text_styles.dart';
import 'package:staff_manager/features/dashboard/presentation/pages/widgets/activity_tile.dart';

class RecentActivitySection extends StatelessWidget {
  const RecentActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent Activity",
          style: AppTextStyles.medium20Dark,
        ),
        SizedBox(height: 12),
        Card(
          elevation: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              ActivityTile(
                title: "New employee added",
                icon: AppIcons.personAdd,
                iconColor: AppColors.primary,
                backgroundColor: AppColors.blueLight,
              ),
              Divider(),
              ActivityTile(
                title: "Employee profile updated",
                icon: AppIcons.edit,
                iconColor: AppColors.green,
                backgroundColor: AppColors.greenLight,
              ),
              Divider(),
              ActivityTile(
                title: "Employee removed from list",
                icon: AppIcons.delete,
                iconColor: AppColors.red,
                backgroundColor: AppColors.redLight,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
