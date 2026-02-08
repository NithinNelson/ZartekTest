import '../../domain/entities/category_entity.dart';
import 'dish_model.dart';

class CategoryModel {
  final int id;
  final String name;
  final List<DishModel> dishes;

  CategoryModel({
    required this.id,
    required this.name,
    required this.dishes,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      dishes: (json['dishes'] as List)
          .map((e) => DishModel.fromJson(e))
          .toList(),
    );
  }

  CategoryEntity toEntity() => CategoryEntity(
    id: id,
    name: name,
    dishes: dishes.map((e) => e.toEntity()).toList(),
  );
}
