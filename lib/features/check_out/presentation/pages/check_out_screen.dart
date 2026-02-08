import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zartek_flutter_test/features/check_out/presentation/controllers/cart_controller.dart';
import 'package:zartek_flutter_test/features/home/domain/entities/dish_entity.dart';
import 'package:zartek_flutter_test/features/home/presentation/widgets/is_veg_icon.dart';
import 'package:zartek_flutter_test/features/home/presentation/widgets/qty_button.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final green = const Color(0xFF174D1F);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Order Summary",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(12.h),
        child: GetX<CartController>(
          builder: (CartController controller) {
            if(controller.dishes.isEmpty) {
              return Center(
                child: Text(
                  'Empty',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                ),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6).r,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(14.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            decoration: BoxDecoration(
                              color: green,
                              borderRadius: BorderRadius.circular(4).r,
                            ),
                            child: Center(
                              child: Text(
                                "${controller.dishes.length} Dishes - ${controller.dishes.length} Items",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 18.h),

                          Expanded(
                            child: ListView.separated(
                              // shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                DishEntity dish =
                                    controller.dishes.value[index];
                                return itemRow(
                                  isVeg: dish.isVeg,
                                  name: dish.name,
                                  price:
                                      "${dish.currency} ${dish.price.toStringAsFixed(2)}",
                                  calories: "${dish.calories} calories",
                                  green: green,
                                  itemIndex: index,
                                  qty: dish.quantity,
                                  total:
                                      "${dish.currency} ${dish.cartTotal.toStringAsFixed(2)}",
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  Divider(height: 28.h),
                              itemCount: controller.dishes.value.length,
                            ),
                          ),

                          Divider(height: 28.h),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Total Amount",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "INR ${controller.dishTotal.value.toStringAsFixed(2)}",
                                style: TextStyle(
                                  color: Colors.green.shade700,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.h,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Container(
                  width: double.infinity,
                  height: 50.h,
                  margin: EdgeInsets.only(top: 12.h),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30).r,
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Place Order",
                      style: TextStyle(
                        fontSize: 16.h,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget itemRow({
    required bool isVeg,
    required String name,
    required String price,
    required String calories,
    required Color green,
    required int itemIndex,
    required int qty,
    required String total,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IsVegIcon(isVeg: isVeg),
        SizedBox(width: 6.h),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 15.h, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 6.h),
              Text(price),
              Text(
                calories,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12.h),
              ),
            ],
          ),
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            QtyButton(
              quantity: qty,
              color: green,
              add: () {
                CartController cartController = Get.find<CartController>();
                cartController.increaseQty(itemIndex);
              },
              subtract: () {
                CartController cartController = Get.find<CartController>();
                cartController.decreaseQty(itemIndex);
              },
            ),
            SizedBox(height: 6.h),
            Text(total),
          ],
        ),
      ],
    );
  }
}
