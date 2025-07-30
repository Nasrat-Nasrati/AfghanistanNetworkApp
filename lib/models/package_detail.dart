import 'package.dart';

class PackageDetail {
  final int id;
  final Package package;
  final String name;
  final String? price;
  final String? activationCode;
  final String? deactivationCode;
  final String? checkBalanceCode;

  PackageDetail({
    required this.id,
    required this.package,
    required this.name,
    this.price,
    this.activationCode,
    this.deactivationCode,
    this.checkBalanceCode,
  });

  factory PackageDetail.fromJson(Map<String, dynamic> json) {
    return PackageDetail(
      id: json['id'],
      package: Package.fromJson(json['package']),
      name: json['name'],
      price: json['price']?.toString(),
      activationCode: json['activation_code'],
      deactivationCode: json['deactivation_code'],
      checkBalanceCode: json['check_balance_code'],
    );
  }
}
