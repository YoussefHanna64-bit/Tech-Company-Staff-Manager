import 'package:flutter/material.dart';
import 'package:staff_manager/core/theme/app_text_styles.dart';

class ActivityTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  const ActivityTile(
      {super.key,
      required this.title,
      required this.icon,
      required this.iconColor,
      required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: backgroundColor,
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
      title: Text(
        title,
        style: AppTextStyles.medium14Dark,
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
      ),
    );
  }
}
