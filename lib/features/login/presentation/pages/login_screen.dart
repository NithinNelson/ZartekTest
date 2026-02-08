import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zartek_flutter_test/config/theme/light_theme.dart';
import 'package:zartek_flutter_test/core/constants/app_text.dart';
import 'package:zartek_flutter_test/core/constants/assets.dart';
import 'package:zartek_flutter_test/features/login/presentation/controllers/login_controller.dart';
import 'package:zartek_flutter_test/routes/app_routes.dart';

import '../../../../core/utils/logger.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    LoginController loginController = Get.find<LoginController>();
    SystemChrome.setSystemUIOverlayStyle(
      systemUiOverlayStyleLight,
    );
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              Image.asset(Assets.firebaseIcon, height: 200.h),

              const Spacer(),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.h),
                child: SizedBox(
                  height: 70.h,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final output = await loginController.loginWithGoogle();
                      if(output != null) {
                        if (!Get.isSnackbarOpen) {
                          Get.snackbar(
                            "Error",
                            output,
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.red,
                            borderRadius: 20,
                            margin: EdgeInsets.all(15),
                            colorText: Colors.white,
                            duration: Duration(seconds: 4),
                            isDismissible: true,
                            forwardAnimationCurve: Curves.easeOutBack,
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.h,
                      ),
                      backgroundColor: const Color(0xFF4A8DFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(500).r,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(6.h),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            shape: BoxShape.circle
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(500).r,
                            child: Image.asset(
                              Assets.googleIcon,
                              height: 25.h,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        Text(
                          AppText.google,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(4.h),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(500).r,
                            child: Image.asset(
                              Assets.googleIcon,
                              height: 30.h,
                              fit: BoxFit.fitHeight,
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.h),
                child: Container(
                  height: 70.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      stops: [0.2, 0.8],
                      colors: [
                        Color(0xFF7CD757),
                        Color(0xFF2FA84F),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(500).r,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      AppRoutes.goNext(AppRoutes.number);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(500).r,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.phone, color: Colors.white, size: 28.h),
                        Text(
                          AppText.phone,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Icon(Icons.phone, color: Colors.transparent, size: 28.h),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 60.h),
            ],
          ),
        ),
      ),
    );
  }
}
