import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/operator.dart';
import '../models/service_package.dart';
import '../models/package.dart';
import '../models/package_detail.dart';
import '../models/gallery.dart';

class ApiService {
  //
  // static const String baseUrl = 'https://afgnetworkapp.onrender.com/api/';

  // static const String baseUrl = 'http://172.16.3.236:8000/api/'; // ← آدرس IP سرور Django را بگذارید
  // this is the dajngo python anywhere server
  static const String baseUrl = 'https://nasrat.pythonanywhere.com/api/';// ← آدرس IP سرور Django را بگذارید


  /// 📡 بررسی اتصال به سرور
  static Future<bool> checkServer() async {
    try {
      final response = await http.get(Uri.parse('${baseUrl}operators/'));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  /// 📦 دریافت لیست اپراتورها
  static Future<List<Operator>> fetchOperators() async {
    final url = Uri.parse('${baseUrl}operators/');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Operator.fromJson(json)).toList();
      } else {
        throw Exception('خطا در دریافت اپراتورها');
      }
    } catch (e) {
      throw Exception('ارتباط با سرور قطع است (Operator)');
    }
  }

  /// 📦 دریافت لیست سرویس پکیج‌ها
  static Future<List<ServicePackage>> fetchServicePackages() async {
    final url = Uri.parse('${baseUrl}service-packages/');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List jsonList = jsonDecode(response.body);
        return jsonList.map((json) => ServicePackage.fromJson(json)).toList();
      } else {
        throw Exception('خطا در دریافت سرویس‌پکیج‌ها');
      }
    } catch (e) {
      throw Exception('ارتباط با سرور قطع است (ServicePackage)');
    }
  }

  /// 📦 دریافت لیست پکیج‌ها
  static Future<List<Package>> fetchPackages() async {
    final url = Uri.parse('${baseUrl}packages/');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Package.fromJson(json)).toList();
      } else {
        throw Exception('خطا در دریافت پکیج‌ها');
      }
    } catch (e) {
      throw Exception('ارتباط با سرور قطع است (Package)');
    }
  }

  /// 📦 دریافت لیست جزئیات پکیج (باندل‌ها)
  static Future<List<PackageDetail>> fetchPackageDetails() async {
    final url = Uri.parse('${baseUrl}package-details/');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List jsonList = jsonDecode(response.body);
        return jsonList.map((json) => PackageDetail.fromJson(json)).toList();
      } else {
        print('🛑 پاسخ سرور: ${response.statusCode} | بدنه: ${response.body}');
        throw Exception('خطا در دریافت جزئیات پکیج');
      }
    } catch (e) {
      print('❌ خطای واقعی: $e');
      throw Exception('ارتباط با سرور قطع است (PackageDetail)');
    }
  }


  /// 🖼️ دریافت لیست تصاویر گالری
  static Future<List<Gallery>> fetchGallery() async {
    final url = Uri.parse('${baseUrl}galleries/');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Gallery.fromJson(json)).toList();
      } else {
        throw Exception('خطا در دریافت گالری');
      }
    } catch (e) {
      throw Exception('ارتباط با سرور قطع است (Gallery)');
    }
  }
}
