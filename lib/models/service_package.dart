import 'operator.dart';

class ServicePackage {
  final int id;
  final String name;
  final bool isServices;
  final Operator operator;

  ServicePackage({
    required this.id,
    required this.name,
    required this.isServices,
    required this.operator,
  });

  factory ServicePackage.fromJson(Map<String, dynamic> json) {
    return ServicePackage(
      id: json['id'],
      name: json['name'],
      isServices: json['is_services'],
      operator: Operator.fromJson(json['operator']),
    );
  }
}
