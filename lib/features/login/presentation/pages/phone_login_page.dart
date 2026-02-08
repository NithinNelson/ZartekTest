import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zartek_flutter_test/features/login/presentation/controllers/login_controller.dart';
import 'package:zartek_flutter_test/routes/app_routes.dart';

class PhoneLoginPage extends StatefulWidget {
  const PhoneLoginPage({super.key});

  @override
  State<PhoneLoginPage> createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  final LoginController controller = Get.find<LoginController>();

  final TextEditingController phoneController = TextEditingController();

  final RxBool isValid = false.obs;

  void validatePhone(String value) {
    isValid.value = RegExp(r'^[6-9]\d{9}$').hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login with Phone")),
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),

            Text(
              "Enter your mobile number",
              style: TextStyle(fontSize: 22.h, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10.h),

            Text(
              "We will send you an OTP to verify your number",
              style: TextStyle(fontSize: 14.h, color: Colors.grey),
            ),

            SizedBox(height: 30.h),

            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.h,
                    vertical: 14.h,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8).r,
                  ),
                  child: Text("+91", style: TextStyle(fontSize: 16.h)),
                ),
                SizedBox(width: 10.h),
                Expanded(
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    onChanged: validatePhone,
                    decoration: InputDecoration(
                      counterText: "",
                      hintText: "Enter mobile number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8).r,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 30.h),

            Obx(
              () => SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: isValid.value
                      ? () async {
                          final phone = "+91${phoneController.text.trim()}";

                          final output = await controller.loginWithPhone(phone);

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
                          if (controller.verificationId.isNotEmpty) {
                            AppRoutes.goNext(AppRoutes.otp);
                          }
                        }
                      : null,
                  child: const Text("Send OTP"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
