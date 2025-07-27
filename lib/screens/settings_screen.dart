import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

enum FontSizeOption { small, medium, large }

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  FontSizeOption _fontSize = FontSizeOption.medium;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: _isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
        appBar: AppBar(
          title: const Text(
            'تنظیمات',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: _isDarkMode ? Colors.grey.shade800 : Colors.blue,
          centerTitle: true,
        ),
        body: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'تنظیمات عمومی',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            // حالت شب / روز
            SwitchListTile(
              title: const Text('حالت شب'),
              subtitle: const Text('فعال‌سازی یا غیرفعال‌سازی حالت تاریک'),
              value: _isDarkMode,
              onChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
              secondary: const Icon(Icons.dark_mode),
            ),

            const Divider(),

            // اندازه فونت
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'اندازه فونت',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            RadioListTile<FontSizeOption>(
              title: const Text('کوچک'),
              value: FontSizeOption.small,
              groupValue: _fontSize,
              onChanged: (value) {
                setState(() {
                  _fontSize = value!;
                });
              },
            ),
            RadioListTile<FontSizeOption>(
              title: const Text('متوسط'),
              value: FontSizeOption.medium,
              groupValue: _fontSize,
              onChanged: (value) {
                setState(() {
                  _fontSize = value!;
                });
              },
            ),
            RadioListTile<FontSizeOption>(
              title: const Text('بزرگ'),
              value: FontSizeOption.large,
              groupValue: _fontSize,
              onChanged: (value) {
                setState(() {
                  _fontSize = value!;
                });
              },
            ),

            const Divider(),

            // تنظیمات آینده
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'سایر تنظیمات',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.notifications),
              title: Text('تنظیمات اعلان'),
              subtitle: Text('در نسخه‌های آینده اضافه می‌شود'),
            ),
            const ListTile(
              leading: Icon(Icons.language),
              title: Text('زبان اپلیکیشن'),
              subtitle: Text('در آینده قابل تنظیم خواهد بود'),
            ),
          ],
        ),
      ),
    );
  }
}
