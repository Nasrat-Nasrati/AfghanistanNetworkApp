import 'package:flutter/material.dart';
import '../models/service_package.dart';
import '../models/package.dart';
import '../api_services/api.dart';

class PackagesScreen extends StatelessWidget {
  final ServicePackage service;

  const PackagesScreen({super.key, required this.service});

  // تابع آیکون‌دهی بر اساس نام پکیج
  IconData getPackageIcon(String name) {
    final lower = name.toLowerCase();

    if (lower.contains('اینترنت') || lower.contains('internet')) {
      return Icons.wifi;
    } else if (lower.contains('تماس') || lower.contains('call')) {
      return Icons.phone;
    } else if (lower.contains('پیام') || lower.contains('sms')) {
      return Icons.sms;
    } else if (lower.contains('اجتماعی') || lower.contains('social')) {
      return Icons.people;
    } else if (lower.contains('یوتیوب') || lower.contains('یوتیبو') || lower.contains('youtube')) {
      return Icons.ondemand_video;
    } else if (lower.contains('تلویزیون') || lower.contains('tv')) {
      return Icons.tv;
    } else if (lower.contains('یک ساعت') || lower.contains('1ساعت') || lower.contains('1 ساعت')) {
      return Icons.schedule;
    } else if (lower.contains('روزانه') || lower.contains('daily')) {
      return Icons.calendar_today;
    } else if (lower.contains('شبانه') || lower.contains('night')) {
      return Icons.nights_stay;
    } else if (lower.contains('هفته وار') || lower.contains('week')) {
      return Icons.view_week;
    } else if (lower.contains('ماهوار') || lower.contains('ماهیانه') || lower.contains('month')) {
      return Icons.date_range;
    } else if (lower.contains('شش ماه') || lower.contains('6ماه') || lower.contains('6 ماه')) {
      return Icons.timelapse;
    } else if (lower.contains('12ماه') || lower.contains('12 ماه') || lower.contains('سال')) {
      return Icons.calendar_month;
    } else if (lower.contains('پلان الفا پرایم') || lower.contains('alpha prime')) {
      return Icons.stars;
    } else if (lower.contains('پلان الفا') || lower.contains('alpha')) {
      return Icons.bolt;
    } else if (lower.contains('15 روزه') || lower.contains('15روزه')) {
      return Icons.timer;
    } else if (lower.contains('60 روزه') || lower.contains('60روزه')) {
      return Icons.timelapse;
    } else if (lower.contains('90 روزه') || lower.contains('90روزه')) {
      return Icons.av_timer;
    } else if (lower.contains('3روزه') || lower.contains('سه روزه')) {
      return Icons.access_time;
    } else if (lower.contains('دوماه') || lower.contains('2ماه') || lower.contains('2 ماه')) {
      return Icons.timeline;
    } else if (lower.contains('روز جمعه') || lower.contains('جمعه')) {
      return Icons.weekend;
    } else if (lower.contains('کامبو') || lower.contains('combo')) {
      return Icons.all_inclusive;
    } else {
      return Icons.local_offer; // آیکون پیش‌فرض
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF1F3F6),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0D47A1),
          elevation: 6,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            service.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
        ),
        body: FutureBuilder<List<Package>>(
          future: ApiService.fetchPackages(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'خطا در دریافت پکیج‌ها: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              );
            }

            final allPackages = snapshot.data ?? [];
            final relatedPackages = allPackages
                .where((pkg) => pkg.servicePackage.id == service.id)
                .toList();

            if (relatedPackages.isEmpty) {
              return const Center(
                child: Text(
                  'هیچ پکیجی برای این سرویس یافت نشد.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.builder(
                itemCount: relatedPackages.length,
                itemBuilder: (context, index) {
                  final pkg = relatedPackages[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      leading: Icon(getPackageIcon(pkg.name), color: const Color(0xFF0D47A1)),
                      title: Text(
                        pkg.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      onTap: () {
                        // در آینده جزئیات بیشتر نمایش داده می‌شود
                      },
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
