import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zartek_flutter_test/config/theme/app_theme.dart';
import 'package:zartek_flutter_test/core/bindings/app_binding.dart';
import 'package:zartek_flutter_test/core/constants/app_constants.dart';
import 'package:zartek_flutter_test/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppConstants.appName,
            theme: AppTheme.lightTheme,
            themeMode: ThemeMode.light,
            getPages: AppRoutes.getPages,
            initialRoute: AppRoutes.login,
            initialBinding: AppBinding(),
          ),
        );
      },
    );
  }
}
