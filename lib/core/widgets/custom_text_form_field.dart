import 'package:flutter/material.dart';
import 'package:staff_manager/core/constants/app_icons.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final String labelText;
  final String hintText;
  final IconData icon;
  final TextInputType keyboardType;
  final String? Function(String?) validator;
  final int? minLines;
  final int? maxLines;
  final bool obscureText;
  final VoidCallback? onToggleVisibility;

  const CustomTextFormField({
    super.key,
    required this.controller,
    this.focusNode,
    this.nextFocusNode,
    required this.labelText,
    required this.hintText,
    required this.icon,
    this.keyboardType = TextInputType.text,
    required this.validator,
    this.minLines,
    this.maxLines,
    this.obscureText = false,
    this.onToggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      validator: validator,
      obscureText: obscureText,
      minLines: obscureText ? 1 : minLines,
      maxLines: obscureText ? 1 : maxLines,
      textInputAction:
          nextFocusNode != null ? TextInputAction.next : TextInputAction.done,
      onTapOutside: (_) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      onFieldSubmitted: (_) {
        if (nextFocusNode != null) {
          nextFocusNode!.requestFocus();
        } else {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(icon),
        suffixIcon: onToggleVisibility != null
            ? IconButton(
                icon: Icon(
                  obscureText ? AppIcons.visibilityOff : AppIcons.visibility,
                ),
                onPressed: onToggleVisibility,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
