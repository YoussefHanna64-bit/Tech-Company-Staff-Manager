import 'package:flutter/material.dart';
import 'package:staff_manager/core/theme/app_colors.dart';

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const InfoRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 4),
        Icon(
          icon,
          color: AppColors.whiteColor,
          size: 22,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: AppColors.whiteColor,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
