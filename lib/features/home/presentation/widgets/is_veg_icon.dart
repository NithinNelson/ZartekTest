
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IsVegIcon extends StatelessWidget {
  final bool isVeg;
  const IsVegIcon({super.key, required this.isVeg});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4.h),
      child: Container(
        height: 18.h,
        width: 18.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: isVeg ? Colors.green : Colors.red,
            width: 1.3.h,
          ),
        ),
        child: Center(
          child: Container(
            height: 10.h,
            width: 10.h,
            decoration: BoxDecoration(
              color: isVeg ? Colors.green : Colors.red,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
