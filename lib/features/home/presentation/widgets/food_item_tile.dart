import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zartek_flutter_test/core/utils/logger.dart';
import 'package:zartek_flutter_test/features/home/presentation/controllers/home_controller.dart';
import 'package:zartek_flutter_test/features/home/presentation/widgets/is_veg_icon.dart';
import 'package:zartek_flutter_test/features/home/presentation/widgets/qty_button.dart';

class FoodItemTile extends StatelessWidget {
  final String title;
  final String price;
  final String calories;
  final String description;
  final String imageUrl;
  final bool isVeg;
  final bool customizationsAvailable;
  final int quantity;
  final int categoryIndex;
  final int dishIndex;

  const FoodItemTile({
    super.key,
    required this.title,
    required this.price,
    required this.calories,
    required this.description,
    required this.imageUrl,
    required this.customizationsAvailable,
    required this.isVeg,
    required this.quantity,
    required this.categoryIndex,
    required this.dishIndex,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [IsVegIcon(isVeg: isVeg)],
          ),
          SizedBox(width: 8.h),

          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(fontSize: 18.h),
                ),
                SizedBox(height: 4.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 14.h),
                    Text(
                      calories,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.h,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 4.h),

                Text(
                  description,
                  style: theme.textTheme.bodySmall?.copyWith(fontSize: 16.h),
                ),

                SizedBox(height: 10.h),

                QtyButton(
                  quantity: quantity,
                  color: Color(0xFF2FA84F),
                  add: () {
                    HomeController homeController = Get.find<HomeController>();
                    homeController.increaseQty(categoryIndex, dishIndex);
                  },
                  subtract: () {
                    HomeController homeController = Get.find<HomeController>();
                    homeController.decreaseQty(categoryIndex, dishIndex);
                  },
                ),

                if (customizationsAvailable) SizedBox(height: 8.h),

                if (customizationsAvailable)
                  Text(
                    "Customizations Available",
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.secondary,
                      fontSize: 16.h,
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(width: 10.h),

          ClipRRect(
            borderRadius: BorderRadius.circular(6).r,
            child: Image.network(
              imageUrl,
              height: 68.h,
              width: 68.h,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
