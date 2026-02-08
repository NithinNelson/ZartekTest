import '../../domain/entities/menu_entity.dart';
import 'category_model.dart';

class MenuModel {
  final List<CategoryModel> categories;

  MenuModel({required this.categories});

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      categories: (json['categories'] as List)
          .map((e) => CategoryModel.fromJson(e))
          .toList(),
    );
  }

  MenuEntity toEntity() => MenuEntity(
    categories: categories.map((e) => e.toEntity()).toList(),
  );
}
