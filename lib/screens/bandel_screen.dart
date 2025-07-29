import 'package:flutter/material.dart';

class BandelScreen extends StatelessWidget {
  final String packageName;

  const BandelScreen({super.key, required this.packageName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // مرکز قرار دادن عنوان
        backgroundColor: const Color(0xFF0D47A1),
        elevation: 6,
        title: Text(
          'بسته‌های $packageName',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: const Center(
        child: Text(
          'در اینجا لیست بسته‌های انتخاب‌شده نمایش داده خواهد شد.',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
