import '../../domain/entities/dish_entity.dart';
import 'addon_model.dart';

class DishModel {
  final int id;
  final String name;
  final double price;
  final String currency;
  final int calories;
  final String description;
  final String imageUrl;
  final bool isVeg;
  final bool hasCustomization;
  final List<AddonModel> addons;

  DishModel({
    required this.id,
    required this.name,
    required this.price,
    required this.currency,
    required this.calories,
    required this.description,
    required this.imageUrl,
    required this.isVeg,
    required this.hasCustomization,
    required this.addons,
  });

  factory DishModel.fromJson(Map<String, dynamic> json) {
    return DishModel(
      id: json['id'],
      name: json['name'],
      price: double.parse(json['price']),
      currency: json['currency'],
      calories: json['calories'],
      description: json['description'],
      imageUrl: json['image_url'],
      isVeg: json['is_veg'],
      hasCustomization: json['customizations_available'],
      addons: (json['addons'] as List? ?? [])
          .map((e) => AddonModel.fromJson(e))
          .toList(),
    );
  }

  DishEntity toEntity() => DishEntity(
    id: id,
    name: name,
    price: price,
    currency: currency,
    calories: calories,
    description: description,
    imageUrl: imageUrl,
    isVeg: isVeg,
    hasCustomization: hasCustomization,
    addons: addons.map((e) => e.toEntity()).toList(),
  );
}
