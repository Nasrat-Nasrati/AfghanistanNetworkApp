import 'package:flutter/material.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  int _selectedStars = 0; // تعداد ستاره‌های انتخاب شده

  Widget _buildStar(int index) {
    return IconButton(
      iconSize: 40,
      icon: Icon(
        index <= _selectedStars ? Icons.star : Icons.star_border,
        color: Colors.amber,
      ),
      onPressed: () {
        setState(() {
          _selectedStars = index;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'حمایت از ما',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.favorite, size: 80, color: Colors.redAccent),
              const SizedBox(height: 24),
              const Text(
                'اگر از این اپلیکیشن خوشتان آمده، می‌توانید از ما حمایت کنید و به ما امتیاز دهید.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // ردیف ستاره‌ها برای انتخاب
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) => _buildStar(index + 1)),
              ),

              const SizedBox(height: 24),

              Text(
                _selectedStars == 0
                    ? 'لطفاً تعداد ستاره‌ها را انتخاب کنید'
                    : 'شما به این اپلیکیشن $_selectedStars ستاره داده‌اید. ممنونیم!',
                style: TextStyle(
                  fontSize: 16,
                  color: _selectedStars == 0 ? Colors.grey : Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
