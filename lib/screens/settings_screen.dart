import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    final isDark = settings.isDarkMode;
    final fontSize = settings.fontSize;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: isDark ? Colors.grey.shade900 : Colors.grey.shade100,
        appBar: AppBar(
          title: const Text('تنظیمات'),
          centerTitle: true,
          backgroundColor: isDark ? Colors.grey.shade800 : Colors.blue,
        ),
        body: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'تنظیمات عمومی',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SwitchListTile(
              title: const Text('حالت شب'),
              subtitle: const Text('فعال‌سازی یا غیرفعال‌سازی حالت تاریک'),
              value: isDark,
              onChanged: (value) {
                settings.toggleDarkMode(value);
              },
              secondary: const Icon(Icons.dark_mode),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'اندازه فونت',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            RadioListTile<FontSizeOption>(
              title: const Text('کوچک'),
              value: FontSizeOption.small,
              groupValue: fontSize,
              onChanged: (value) {
                settings.updateFontSize(value!);
              },
            ),
            RadioListTile<FontSizeOption>(
              title: const Text('متوسط'),
              value: FontSizeOption.medium,
              groupValue: fontSize,
              onChanged: (value) {
                settings.updateFontSize(value!);
              },
            ),
            RadioListTile<FontSizeOption>(
              title: const Text('بزرگ'),
              value: FontSizeOption.large,
              groupValue: fontSize,
              onChanged: (value) {
                settings.updateFontSize(value!);
              },
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'سایر تنظیمات',
                style: TextStyle(fontWeight: FontWeight.bold),
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
