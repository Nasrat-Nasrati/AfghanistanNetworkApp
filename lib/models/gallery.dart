import 'operator.dart';

class Gallery {
  final int id;
  final Operator operator;
  final String image;
  final String? caption;

  Gallery({
    required this.id,
    required this.operator,
    required this.image,
    this.caption,
  });

  factory Gallery.fromJson(Map<String, dynamic> json) {
    return Gallery(
      id: json['id'],
      operator: Operator.fromJson(json['operator']),
      image: json['image'],
      caption: json['caption'],
    );
  }
}
