import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.rtl, // راست‌چین برای کل اپلیکیشن
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'اپراتورها',
        home: HomeScreen(),
      ),
    );
  }
}
