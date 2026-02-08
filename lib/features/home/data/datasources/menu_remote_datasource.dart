import '../models/menu_item_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class MenuRemoteDatasource {
  Future<MenuModel> getMenu();
}

class MenuRemoteDatasourceImpl implements MenuRemoteDatasource {
  final http.Client client;

  MenuRemoteDatasourceImpl(this.client);

  @override
  Future<MenuModel> getMenu() async {
    final response = await client.get(
      Uri.parse("https://faheemkodi.github.io/mock-menu-api/menu.json"),
    );

    if (response.statusCode == 200) {
      return MenuModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load menu");
    }
  }
}
