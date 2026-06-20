import 'package:flutter/material.dart';
import 'package:staff_manager/core/theme/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  const CustomButton(
      {super.key, required this.label, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: FilledButton.icon(
        onPressed: onPressed,
        icon: icon != null ? Icon(icon) : const Icon(Icons.login),
        label: Text(label, style: AppTextStyles.medium16Dark),
      ),
    );
  }
}
