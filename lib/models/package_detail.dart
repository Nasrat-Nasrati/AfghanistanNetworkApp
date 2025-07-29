import 'package.dart';

class PackageDetail {
  final int id;
  final Package package;
  final String name;
  final String? price; // ← نوع به String? تغییر یافت
  final String? activationCode;
  final String? deactivationCode;
  final String? checkBalanceCode;
  final String code;
  final String? description;
  final String buttonActive;
  final String buttonDeactive;
  final String buttonCheckBalance;

  PackageDetail({
    required this.id,
    required this.package,
    required this.name,
    this.price,
    this.activationCode,
    this.deactivationCode,
    this.checkBalanceCode,
    required this.code,
    this.description,
    required this.buttonActive,
    required this.buttonDeactive,
    required this.buttonCheckBalance,
  });

  factory PackageDetail.fromJson(Map<String, dynamic> json) {
    return PackageDetail(
      id: json['id'],
      package: Package.fromJson(json['package']),
      name: json['name'],
      price: json['price']?.toString(), // ← اطمینان از تبدیل به رشته
      activationCode: json['activation_code'],
      deactivationCode: json['deactivation_code'],
      // checkBalanceCode: json['check_balance_code'],
      code: json['code'],
      description: json['description'],
      buttonActive: json['button_active'],
      buttonDeactive: json['button_deactive'],
      buttonCheckBalance: json['button_check_blance'],
    );
  }
}









