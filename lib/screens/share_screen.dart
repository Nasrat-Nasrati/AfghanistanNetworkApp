import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareScreen extends StatelessWidget {
  const ShareScreen({super.key});

  void _shareApp(BuildContext context) {
    Share.share(
      'سلام! 👋\n\nاین اپلیکیشن خدمات شبکه‌های مخابراتی افغانستان را از لینک زیر دریافت کنید:\n\nhttps://example.com/app_download\n\nنصرت نصرتی 👨‍💻',
      subject: 'اشتراک‌گذاری اپلیکیشن خدمات شبکه',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'اشتراک‌گذاری',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.share, size: 80, color: Colors.blueAccent),
              const SizedBox(height: 24),
              const Text(
                'شما می‌توانید این اپلیکیشن را با دوستان و خانواده‌ی خود از طریق بلوتوث، شبکه‌های اجتماعی، ایمیل و دیگر اپ‌ها به اشتراک بگذارید.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.send),
                  label: const Text(
                    'اشتراک‌گذاری اپلیکیشن',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => _shareApp(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
