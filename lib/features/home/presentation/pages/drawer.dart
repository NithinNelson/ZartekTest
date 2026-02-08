import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zartek_flutter_test/features/login/presentation/controllers/login_controller.dart';

import '../widgets/user_provider_widget.dart';

class ProfileDrawer extends StatelessWidget {
  ProfileDrawer({super.key});
  final LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    User? user = UserProvider.of(context)?.user;
    return Drawer(
      backgroundColor: Colors.white,
      width: 400.h,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 70.h, bottom: 20.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25).r,
                bottomRight: Radius.circular(25).r,
              ),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 32.r,
                  backgroundColor: Colors.orange.shade200,
                  child: Icon(Icons.person, color: Colors.grey, size: 35.h),
                ),

                SizedBox(height: 10.h),

                Text(
                  user?.email ?? user?.phoneNumber ?? '--',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.h,
                  ),
                ),

                SizedBox(height: 4.h),

                Text(
                  "ID : ${user?.uid ?? '--'}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16.h,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20.h),

          ListTile(
            leading: Icon(Icons.logout, color: Colors.grey, size: 30.h),
            title: Text(
              "Log out",
              style: TextStyle(fontSize: 18.h),
            ),
            onTap: () async {
              await loginController.logOutApp();
            },
          ),
        ],
      ),
    );
  }
}
