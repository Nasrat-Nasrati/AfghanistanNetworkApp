import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/package_detail.dart';
import '../api_services/api.dart';

class BandelScreen extends StatelessWidget {
  final int packageId;
  final String packageName;

  const BandelScreen({
    super.key,
    required this.packageId,
    required this.packageName,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xFF0D47A1),
          elevation: 4,
          title: Text(
            'بسته‌های $packageName',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
        body: FutureBuilder<List<PackageDetail>>(
          future: ApiService.fetchPackageDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '❌ خطا در دریافت داده‌ها: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            final allDetails = snapshot.data ?? [];
            final filtered = allDetails
                .where((detail) => detail.package.id == packageId)
                .toList();

            if (filtered.isEmpty) {
              return const Center(child: Text('هیچ بسته‌ای یافت نشد.'));
            }

            return Padding(
              padding: const EdgeInsets.all(8),
              child: ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final item = filtered[index];

                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // نام بسته و قیمت
                          Row(
                            children: [
                              _buildInfoCardSmall(
                                'نام بسته',
                                item.name,
                                Colors.lightBlue.shade50,
                              ),
                              const SizedBox(width: 10),
                              if (item.price != null)
                                _buildInfoCardSmall(
                                  'قیمت',
                                  '${item.price} افغانی',
                                  Colors.green.shade50,
                                ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          // کدهای USSD
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              if (item.activationCode != null)
                                _buildInfoCardSmall(
                                  'کد فعال‌سازی',
                                  'برای فعال‌سازی ${item.activationCode} را دایل کنید',
                                  Colors.green.shade100,
                                ),
                              if (item.deactivationCode != null)
                                _buildInfoCardSmall(
                                  'کد غیرفعال‌سازی',
                                  'برای غیرفعال‌سازی ${item.deactivationCode} را دایل کنید',
                                  Colors.red.shade100,
                                ),

                            ],
                          ),

                          const SizedBox(height: 12),

                          // دکمه‌ها
                          Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (item.activationCode != null &&
                                    _isValidUSSD(item.activationCode!))
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 14),
                                    child: _buildMiniButton(
                                      'فعال‌سازی',
                                      Colors.green,
                                      item.activationCode!,
                                    ),
                                  ),
                                if (item.deactivationCode != null &&
                                    _isValidUSSD(item.deactivationCode!))
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 14),
                                    child: _buildMiniButton(
                                      'غیرفعال‌سازی',
                                      Colors.red,
                                      item.deactivationCode!,
                                    ),
                                  ),
                                if (item.checkBalanceCode != null &&
                                    _isValidUSSD(item.checkBalanceCode!))
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 14),
                                    child: _buildMiniButton(
                                      'بررسی موجودی',
                                      Colors.orange,
                                      item.checkBalanceCode!,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
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

  // بررسی اعتبار کد USSD
  bool _isValidUSSD(String code) {
    final trimmed = code.trim();
    return trimmed.startsWith("*") &&
        trimmed.endsWith("#") &&
        trimmed.length >= 4;
  }

  // اجرای USSD
  Future<void> _dialUSSDCode(String code) async {
    final trimmed = code.trim();
    final Uri ussdUri = Uri(scheme: 'tel', path: Uri.encodeComponent(trimmed));
    if (await canLaunchUrl(ussdUri)) {
      await launchUrl(ussdUri);
    } else {
      debugPrint('⛔ اجرای USSD ممکن نیست: $code');
    }
  }

  // کارت اطلاعات
  Widget _buildInfoCardSmall(String label, String value, Color bgColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            '$label: $value',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  // دکمه اجرای USSD
  Widget _buildMiniButton(String label, Color color, String code) {
    return ElevatedButton(
      onPressed: () => _dialUSSDCode(code),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        backgroundColor: color.withOpacity(0.2),
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 1,
        textStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
      child: Center(
        child: Text(label),
      ),
    );
  }
}

