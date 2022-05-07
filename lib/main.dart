import 'providers/theme_provider.dart';
import 'screens/calculator_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, ThemeProvider themeNotifier, child) {
          return MaterialApp(
            title: 'Calculator',
            theme: themeNotifier.isDark
                ? ThemeData(
                    fontFamily: "SFPro",
                    canvasColor: const Color(0xFF555A60),
                    colorScheme: ColorScheme.dark(
                      primary: const Color(0xFFE3E9EC),
                      secondary: const Color(0xFFF4AB41),
                      tertiary: const Color(0xFFF4AB41).withOpacity(0.1),
                    ),
                  )
                : ThemeData(
                    fontFamily: "SFPro",
                    canvasColor: Colors.white,
                    colorScheme: const ColorScheme.light(
                      primary: Color(0xFF555A60),
                      secondary: Color(0xFFF4AB41),
                      tertiary: Color(0xFFE3E9EC),
                    ),
                  ),
            home: const CalculatorScreen(),
          );
        },
      ),
    );
  }
}
