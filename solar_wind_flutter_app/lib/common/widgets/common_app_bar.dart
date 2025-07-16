import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar_wind_flutter_app/core/theme/theme_provider.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Widget? trailing;
  final String? title;

  const CommonAppBar({
    super.key,
    this.leading,
    this.trailing,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = themeProvider.isDarkMode;

    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      elevation: 0,
      leading: leading != null
          ? Padding(
              padding: const EdgeInsets.only(left: 8),
              child: leading,
            )
          : null,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            iconSize: 28,
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            onPressed: () => themeProvider.toggleTheme(),
            tooltip: 'Toggle Theme',
          ),
        ],
      ),
      centerTitle: true,
      actions: trailing != null
          ? [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: trailing!,
              )
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
