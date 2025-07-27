import 'package:flutter/material.dart';
import '../api_services/api.dart';
import '../models/operator.dart';
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

  @override
  void initState() {
    super.initState();
    _operatorFuture = ApiService.fetchOperators();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'شبکه های افغانستان',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
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
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('درباره ما'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutScreen()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.contact_mail),
                title: const Text('ارتباط با ما'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ContactScreen()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text('حمایت از ما'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const SupportScreen()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text('اشتراک‌گذاری'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ShareScreen()));
                },
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            // 🔷 بخش اول (Placeholder برای اسلایدشو یا تصویر در آینده)
            Container(
              height: MediaQuery.of(context).size.height * 0.4, // 40% از صفحه
              color: Colors.grey[200],
              child: const Center(
                child: Text(
                  'اسلایدشو (در آینده)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // 🔷 بخش دوم: نمایش اپراتورها
            Expanded(
              child: FutureBuilder<List<Operator>>(
                future: _operatorFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text('خطا: ${snapshot.error}', style: const TextStyle(color: Colors.red)),
                    );
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
                              errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 80),
                            )
                                : const Icon(Icons.account_circle, size: 80),
                            const SizedBox(height: 8),
                            Text(
                              operator.name,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
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





