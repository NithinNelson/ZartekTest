import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:zartek_flutter_test/features/login/presentation/controllers/login_controller.dart';

class OtpPage extends StatelessWidget {
  OtpPage({super.key});

  final LoginController controller = Get.find<LoginController>();

  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50.h,
      height: 55.h,
      textStyle: TextStyle(
        fontSize: 20.h,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10).r,
        border: Border.all(color: Colors.grey.shade400),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Verify OTP")),
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),

            Text(
              "Enter OTP",
              style: TextStyle(fontSize: 22.h, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 8.h),

            const Text(
              "We sent a 6-digit code to your mobile number",
              style: TextStyle(color: Colors.grey),
            ),

            SizedBox(height: 30.h),

            Center(
              child: Pinput(
                controller: otpController,
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(color: Colors.blue),
                  ),
                ),
                submittedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(color: Colors.green),
                  ),
                ),
                onCompleted: (pin) async {
                  await controller.verifyOtp(pin);
                },
              ),
            ),

            SizedBox(height: 40.h),

            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () async {
                  await controller.verifyOtp(otpController.text.trim());
                },
                child: const Text("Verify & Login"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
