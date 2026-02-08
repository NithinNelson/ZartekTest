import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SnackBarService {
  static void showNetworkStatus(bool isOffline) {
    Get.rawSnackbar(
      messageText: Container(
        padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        color: isOffline ? Colors.black : Colors.green,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isOffline)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 15.h,
                    width: 15.h,
                    child: Icon(Icons.signal_wifi_off, color: Colors.grey),
                  ),
                  SizedBox(width: 8.h),
                ],
              ),
            Text(
              isOffline
                  ? "Please connect to the internet"
                  : "Online",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12.h,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      duration: Duration(days: 1),
      snackStyle: SnackStyle.GROUNDED,
      isDismissible: false,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
    );
  }
}
