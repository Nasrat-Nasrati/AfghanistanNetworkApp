class Operator {
  final int id;
  final String name;
  final String logo; // URL from ImageField
  final String description;

  Operator({
    required this.id,
    required this.name,
    required this.logo,
    required this.description,
  });

  factory Operator.fromJson(Map<String, dynamic> json) {
    return Operator(
      id: json['id'],
      name: json['name'],
      logo: json['logo'], // full image URL will come here
      description: json['description'],
    );
  }
}
