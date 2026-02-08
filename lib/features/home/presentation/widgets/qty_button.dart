import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QtyButton extends StatelessWidget {
  final int quantity;
  final Color color;
  final VoidCallback add;
  final VoidCallback subtract;
  const QtyButton({
    super.key,
    required this.quantity,
    required this.color,
    required this.add,
    required this.subtract,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: 160.h,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shadowColor: color,
          // padding: EdgeInsets.symmetric(horizontal: 20.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(500).r,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 40.h,
              child: IconButton(
                onPressed: () {
                  subtract.call();
                },
                padding: EdgeInsets.zero,
                icon: Icon(Icons.remove, color: Colors.white, size: 20.h),
              ),
            ),
            Text(
              "$quantity",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.h,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              width: 40.h,
              child: IconButton(
                onPressed: () {
                  add.call();
                },
                padding: EdgeInsets.zero,
                icon: Icon(Icons.add, color: Colors.white, size: 20.h),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
