import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:zartek_flutter_test/core/utils/logger.dart';
import 'package:zartek_flutter_test/features/login/domain/usecases/log_out_usecase.dart';

import '../../../../routes/app_routes.dart';
import '../../data/datasources/auth_remote_datasource_impl.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/google_sign_in_usecase.dart';
import '../../domain/usecases/phone_sign_in_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';

class LoginController extends GetxController {
  final datasource = AuthRemoteDatasourceImpl();
  late final repository = AuthRepositoryImpl(datasource);

  late final googleLogin = GoogleSignInUseCase(repository);
  late final phoneLogin = PhoneSignInUseCase(repository);
  late final verifyOtpUseCase = VerifyOtpUseCase(repository);
  late final logOutUseCase = LogOutUseCase(repository);

  final _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();

    _auth.authStateChanges().listen((user) {
      if (user != null) {
        Get.offAllNamed(AppRoutes.home);
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
    });
  }

  var loading = false.obs;
  var verificationId = ''.obs;

  Future<void> loginWithGoogle() async {
    loading.value = true;
    final user = await googleLogin();
    loading.value = false;

    if (user != null) {
      printDebug("Google Login Success: ${user.email}");
    }
  }

  Future<void> loginWithPhone(String phone) async {
    await phoneLogin(phone);
    verificationId.value = datasource.verificationId ?? '';
  }

  Future<void> verifyOtp(String otp) async {
    final user = await verifyOtpUseCase(verificationId.value, otp);
    if (user != null) {
      printDebug("Phone Login Success: ${user.phone}");
    }
  }

  Future<void> logOutApp() async {
    await logOutUseCase();
  }
}
