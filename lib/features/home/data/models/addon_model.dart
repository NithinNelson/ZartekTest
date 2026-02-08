import '../../domain/entities/addon_entity.dart';

class AddonModel {
  final int id;
  final String name;
  final double price;

  AddonModel({
    required this.id,
    required this.name,
    required this.price,
  });

  factory AddonModel.fromJson(Map<String, dynamic> json) {
    return AddonModel(
      id: json['id'],
      name: json['name'],
      price: double.parse(json['price']),
    );
  }

  AddonEntity toEntity() => AddonEntity(
    id: id,
    name: name,
    price: price,
  );
}
