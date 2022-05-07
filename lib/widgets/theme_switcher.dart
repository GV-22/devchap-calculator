import '../providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeModeSwitcher extends StatefulWidget {
  const ThemeModeSwitcher({Key? key}) : super(key: key);

  @override
  State<ThemeModeSwitcher> createState() => _ThemeModeSwitcherState();
}

class _ThemeModeSwitcherState extends State<ThemeModeSwitcher> {
  // bool _isDark = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    const double iconSize = 24;

    // final isDark = Provider.of<ThemeProvider>()

    return Consumer<ThemeProvider>(
      builder: (context, theme, child) {
        final iconColor = theme.isDark ? Colors.amber : colorScheme.primary;

        return GestureDetector(
          onTap: () async {
            await theme.setDarkMode(!theme.isDark);
          },
          child: Container(
            // width: 100,
            // height: 20,
            // width: 30,
            decoration: BoxDecoration(
              color: theme.isDark ? Colors.black : colorScheme.secondary,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
            child: Column(
              children: [
                // top icon
                SizedBox(
                  height: iconSize,
                  child: theme.isDark
                      ? Icon(
                          Icons.circle,
                          size: iconSize,
                          color: iconColor,
                        )
                      : Icon(
                          Icons.light_mode,
                          size: 10,
                          color: iconColor,
                        ),
                ),
                // const SizedBox(height: 1),
                // bottom icon
                SizedBox(
                  height: iconSize,
                  child: theme.isDark
                      ? Icon(
                          Icons.dark_mode,
                          size: 15,
                          color: iconColor,
                        )
                      : Icon(
                          Icons.circle,
                          size: iconSize,
                          color: iconColor,
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
