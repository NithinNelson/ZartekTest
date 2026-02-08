import 'addon_entity.dart';

class DishEntity {
  final int id;
  final int? categoryId;
  final String name;
  final double price;
  final String currency;
  final int calories;
  final int totalCalories;
  final String description;
  final String imageUrl;
  final bool isVeg;
  final bool inCart;
  final bool hasCustomization;
  final List<AddonEntity> addons;
  final int quantity;
  final double cartTotal;

  const DishEntity({
    required this.id,
    this.categoryId,
    required this.name,
    required this.price,
    required this.currency,
    required this.calories,
    required this.description,
    required this.imageUrl,
    required this.isVeg,
    this.inCart = false,
    required this.hasCustomization,
    required this.addons,
    this.quantity = 0,
    this.cartTotal = 0,
    this.totalCalories = 0,
  });

  DishEntity copyWith({
    int? quantity,
    bool? inCart,
    int? categoryId,
    double? cartTotal,
    int? totalCalories,
  }) {
    return DishEntity(
      id: id,
      categoryId: categoryId ?? this.categoryId,
      name: name,
      price: price,
      currency: currency,
      calories: calories,
      description: description,
      imageUrl: imageUrl,
      isVeg: isVeg,
      inCart: inCart ?? this.inCart,
      hasCustomization: hasCustomization,
      addons: addons,
      quantity: quantity ?? this.quantity,
      cartTotal: cartTotal ?? this.cartTotal,
      totalCalories: totalCalories ?? this.totalCalories,
    );
  }
}
