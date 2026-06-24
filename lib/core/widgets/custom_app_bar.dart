import 'package:flutter/material.dart';
import 'package:staff_manager/core/constants/app_icons.dart';
import 'package:staff_manager/features/auth/presentation/pages/login_page.dart';

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
          icon: Icon(isDark ? AppIcons.lightMode : AppIcons.darkMode),
          onPressed: () {
            onThemeChanged(!isDark);
          },
        ),
        ...actions,
        IconButton(
          icon: const Icon(AppIcons.logout),
          tooltip: 'Logout',
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => LoginPage(
                  isDark: isDark,
                  onThemeChanged: onThemeChanged,
                ),
              ),
              (route) => false,
            );
          },
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
