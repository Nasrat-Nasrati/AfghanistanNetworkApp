import 'service_package.dart';

class Package {
  final int id;
  final String name;
  final ServicePackage servicePackage;

  Package({
    required this.id,
    required this.name,
    required this.servicePackage,
  });

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      id: json['id'],
      name: json['name'],
      servicePackage: ServicePackage.fromJson(json['service_package']),
    );
  }
}
