import 'package:flutter/material.dart';
import 'dart:async';

import '../api_services/api.dart';
import '../models/operator.dart';
import '../models/gallery.dart';
import 'settings_screen.dart';
import 'about_screen.dart';
import 'contact_screen.dart';
import 'support_screen.dart';
import 'share_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Operator>> _operatorFuture;
  late Future<List<Gallery>> _galleryFuture;
  PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;
  bool _isSlideshowStarted = false;

  @override
  void initState() {
    super.initState();
    _operatorFuture = ApiService.fetchOperators();
    _galleryFuture = ApiService.fetchGallery();
  }

  void _startAutoSlide(int length) {
    if (_isSlideshowStarted || length <= 1) return; // فقط یک‌بار اجرا شود
    _isSlideshowStarted = true;

    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_currentPage < length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('شبکه های افغانستان', style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text('منو', style: TextStyle(color: Colors.white, fontSize: 24)),
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('تنظیمات'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen())),
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('درباره ما'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutScreen())),
              ),
              ListTile(
                leading: const Icon(Icons.contact_mail),
                title: const Text('ارتباط با ما'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ContactScreen())),
              ),
              ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text('حمایت از ما'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SupportScreen())),
              ),
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text('اشتراک‌گذاری'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ShareScreen())),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            // 🔷 اسلایدشو
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: FutureBuilder<List<Gallery>>(
                future: _galleryFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('خطا در دریافت تصاویر: ${snapshot.error}'));
                  }

                  final images = snapshot.data ?? [];

                  if (images.isEmpty) {
                    return const Center(child: Text('هیچ تصویری برای نمایش نیست.'));
                  }

                  // فقط یک‌بار اسلایدشو را شروع کن
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _startAutoSlide(images.length);
                  });

                  return Stack(
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        itemCount: images.length,
                        onPageChanged: (index) {
                          setState(() => _currentPage = index);
                        },
                        itemBuilder: (context, index) {
                          final gallery = images[index];
                          return Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                gallery.image,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                const Icon(Icons.broken_image, size: 100),
                              ),
                              if (gallery.caption != null)
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    color: Colors.black54,
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      gallery.caption!,
                                      style: const TextStyle(color: Colors.white, fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                      // 🔹 دکمه قبلی
                      Positioned(
                        left: 8,
                        top: MediaQuery.of(context).size.height * 0.18,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                          onPressed: () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                      ),
                      // 🔹 دکمه بعدی
                      Positioned(
                        right: 8,
                        top: MediaQuery.of(context).size.height * 0.18,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                          onPressed: () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                      ),
                      // 🔹 دایره‌ها
                      Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(images.length, (index) {
                            return Container(
                              width: 10,
                              height: 10,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentPage == index ? Colors.white : Colors.white60,
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // 🔷 نمایش اپراتورها
            Expanded(
              child: FutureBuilder<List<Operator>>(
                future: _operatorFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('خطا: ${snapshot.error}', style: TextStyle(color: Colors.red)));
                  }

                  final operators = snapshot.data ?? [];

                  if (operators.isEmpty) {
                    return const Center(child: Text('هیچ اپراتوری یافت نشد.'));
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1,
                    ),
                    itemCount: operators.length,
                    itemBuilder: (context, index) {
                      final operator = operators[index];
                      return Card(
                        elevation: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            operator.logo.isNotEmpty
                                ? Image.network(
                              operator.logo,
                              width: 80,
                              height: 80,
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) =>
                              const Icon(Icons.broken_image, size: 80),
                            )
                                : const Icon(Icons.account_circle, size: 80),
                            const SizedBox(height: 8),
                            Text(operator.name,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}




