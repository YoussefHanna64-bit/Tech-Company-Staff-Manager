import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;
  final List<Widget> actions;
  const CustomAppBar({
    super.key,
    required this.title,
    required this.isDark,
    required this.onThemeChanged,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(title),
      actions: [
        IconButton(
          icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
          onPressed: () {
            onThemeChanged(!isDark);
          },
        ),
        ...actions,
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
