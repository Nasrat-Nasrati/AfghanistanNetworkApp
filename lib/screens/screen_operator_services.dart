

import 'package:flutter/material.dart';
import '../models/operator.dart';
import '../models/service_package.dart';
import '../api_services/api.dart';
import 'packages_screen.dart';

class OperatorServicesScreen extends StatefulWidget {
  final Operator operatorData;

  const OperatorServicesScreen({super.key, required this.operatorData});

  @override
  State<OperatorServicesScreen> createState() => _OperatorServicesScreenState();
}

class _OperatorServicesScreenState extends State<OperatorServicesScreen> {
  late Future<List<ServicePackage>> _servicePackagesFuture;

  @override
  void initState() {
    super.initState();
    _servicePackagesFuture = ApiService.fetchServicePackages();
  }

  /// 🔍 تابع انتخاب آیکن براساس نام سرویس
  IconData _getIconForService(String name) {
    final lowerName = name.toLowerCase();

    if (lowerName.contains('انترنت') || lowerName.contains('internet') || lowerName.contains('data')) {
      return Icons.wifi;
    } else if (lowerName.contains('پیام') || lowerName.contains('sms') || lowerName.contains('پیامک')) {
      return Icons.sms;
    } else if (lowerName.contains('تماس') || lowerName.contains('call')) {
      return Icons.phone;
    } else if (lowerName.contains('شبانه') || lowerName.contains('night')) {
      return Icons.nightlight_round;
    } else if (lowerName.contains('اجتماعی') || lowerName.contains('social')) {
      return Icons.people_alt;
    } else if (lowerName.contains('مکمل') || lowerName.contains('اضافی') || lowerName.contains('extra')) {
      return Icons.extension;
    } else if (lowerName.contains('خدمات') || lowerName.contains('services')) {
      return Icons.settings;
    } else if (lowerName.contains('بسته') || lowerName.contains('پکیج') || lowerName.contains('package')) {
      return Icons.widgets;
    } else if (lowerName.contains('هفتگی') || lowerName.contains('week')) {
      return Icons.calendar_view_week;
    } else if (lowerName.contains('ماهیانه') || lowerName.contains('ماه') || lowerName.contains('month')) {
      return Icons.calendar_today;
    } else if (lowerName.contains('رایگان') || lowerName.contains('free')) {
      return Icons.card_giftcard;
    } else {
      return Icons.local_offer; // پیش‌فرض
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(
          widget.operatorData.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1565C0),
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Material(
              elevation: 5,
              shape: const CircleBorder(),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: widget.operatorData.logo.isNotEmpty
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.network(
                    widget.operatorData.logo,
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) =>
                    const Icon(Icons.broken_image, size: 100),
                  ),
                )
                    : const Icon(Icons.account_circle, size: 100, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'لیست خدمات ${widget.operatorData.name}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<ServicePackage>>(
                future: _servicePackagesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text('خطا در دریافت خدمات: ${snapshot.error}'),
                    );
                  }

                  final allPackages = snapshot.data ?? [];
                  final filteredPackages = allPackages
                      .where((pkg) => pkg.operator.id == widget.operatorData.id)
                      .toList();

                  if (filteredPackages.isEmpty) {
                    return const Center(
                      child: Text('هیچ خدمتی برای این اپراتور یافت نشد.'),
                    );
                  }

                  return GridView.builder(
                    itemCount: filteredPackages.length,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.95,
                    ),
                    itemBuilder: (context, index) {
                      final service = filteredPackages[index];
                      final icon = _getIconForService(service.name);

                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 3,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PackagesScreen(service: service),
                              ),
                            );
                          },

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(icon, size: 48, color: Colors.blue.shade700),
                              const SizedBox(height: 12),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  service.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
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
