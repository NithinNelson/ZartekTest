import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zartek_flutter_test/config/theme/light_theme.dart';
import 'package:zartek_flutter_test/core/utils/logger.dart';
import 'package:zartek_flutter_test/features/home/domain/entities/category_entity.dart';
import 'package:zartek_flutter_test/features/home/presentation/pages/drawer.dart';
import 'package:zartek_flutter_test/features/home/presentation/widgets/empty_view.dart';
import 'package:zartek_flutter_test/features/home/presentation/widgets/user_provider_widget.dart';
import 'package:zartek_flutter_test/routes/app_routes.dart';

import '../../domain/entities/dish_entity.dart';
import '../controllers/home_controller.dart';
import '../widgets/food_item_tile.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void _initTabController(int length) {
    _tabController?.dispose();
    _tabController = TabController(length: length, vsync: this);

    _tabController!.addListener(() {
      printDebug('Tab index: ${_tabController!.index}');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyleLight);
    return UserProvider(
      user: FirebaseAuth.instance.currentUser,
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (context) {
              return InkWell(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Icon(Icons.menu, size: 30.h),
              );
            },
          ),
          actions: [
            Stack(
              children: [
                IconButton(
                  onPressed: () {
                    AppRoutes.goNext(AppRoutes.checkOut);
                  },
                  icon: Icon(
                    Icons.shopping_cart,
                    size: 30.h,
                    color: Colors.grey,
                  ),
                ),
                Positioned(
                  right: 6.h,
                  top: 6.h,
                  child: Container(
                    height: 16.h,
                    width: 16.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: GetX<HomeController>(
                        builder: (HomeController controller) {
                          return Text(
                            "${controller.totalCartItem.value}",
                            style: TextStyle(
                              fontSize: 12.h,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        drawer: ProfileDrawer(),
        body: GetX<HomeController>(
          builder: (HomeController controller) {
            List<CategoryEntity> categories =
                controller.menu.value?.categories ?? [];

            if (_tabController == null && categories.isNotEmpty) {
              _initTabController(categories.length);
            }

            if (controller.loading.value) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 15.h),
                    Text(
                      'Loading...',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              );
            } else if (controller.errorMessage.value != null) {
              return EmptyView(
                controller: controller,
                message:
                    controller.errorMessage.value ?? 'Something went wrong',
              );
            } else if (categories.isEmpty) {
              return EmptyView(controller: controller, message: 'Empty');
            } else {
              return Column(
                children: [
                  Material(
                    elevation: 3,
                    shadowColor: Colors.grey.withValues(alpha: 0.5),
                    child: TabBar(
                      controller: _tabController,
                      dividerColor: Colors.transparent,
                      indicatorColor: Theme.of(context).colorScheme.secondary,
                      dividerHeight: 2.h,
                      padding: EdgeInsets.zero,
                      indicatorWeight: 2.h,
                      indicatorSize: TabBarIndicatorSize.tab,
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      labelPadding: EdgeInsets.symmetric(horizontal: 15.h),
                      indicatorPadding: EdgeInsets.zero,
                      tabs: categories.map((category) {
                        return SizedBox(
                          height: 50.h,
                          child: Center(
                            child: Text(
                              category.name,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.secondary,
                                    fontSize: 18.h,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Divider(height: 1.h),
                  Expanded(
                    child: IndexedStack(
                      index: _tabController?.index ?? 0,
                      children: [
                        for (int i = 0; i < categories.length; i++)
                          if (categories[i].dishes.isEmpty)
                            EmptyView(controller: controller, message: 'Empty')
                          else
                            RefreshIndicator(
                              onRefresh: () async {
                                await controller.fetchMenu(loader: false);
                              },
                              child: ListView.separated(
                                padding: EdgeInsets.symmetric(
                                  vertical: 15.h,
                                  // horizontal: 10.h,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  DishEntity? dish =
                                      categories[i].dishes[index];
                                  return FoodItemTile(
                                    title: dish.name,
                                    price: "${dish.currency} ${dish.price}",
                                    calories: "${dish.calories} calories",
                                    description: dish.description,
                                    imageUrl: dish.imageUrl,
                                    customizationsAvailable:
                                        dish.hasCustomization,
                                    isVeg: dish.isVeg,
                                    quantity: dish.quantity,
                                    categoryIndex: i,
                                    dishIndex: index,
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        Divider(),
                                itemCount: categories[i].dishes.length ?? 0,
                              ),
                            ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
