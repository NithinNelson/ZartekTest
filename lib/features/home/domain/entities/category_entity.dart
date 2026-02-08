import 'dish_entity.dart';

class CategoryEntity {
  final int id;
  final String name;
  final List<DishEntity> dishes;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.dishes,
  });
}
