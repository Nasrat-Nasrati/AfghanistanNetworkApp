import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/settings_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => SettingsProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);

    return Directionality(
      textDirection: TextDirection.rtl, // راست‌چین برای کل اپلیکیشن
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'اپراتورها',
        theme: ThemeData(
          brightness: settings.isDarkMode ? Brightness.dark : Brightness.light,
          textTheme: TextTheme(
            bodyMedium: TextStyle(fontSize: settings.getFontSizeValue()),
            bodyLarge: TextStyle(fontSize: settings.getFontSizeValue()),
            titleMedium: TextStyle(fontSize: settings.getFontSizeValue() + 2),
          ),
        ),
        home: const HomeScreen(), // صفحه‌ی اصلی شما
      ),
    );
  }
}
