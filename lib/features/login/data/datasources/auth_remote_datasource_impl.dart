import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_model.dart';
import 'auth_remote_datasource.dart';

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  String? _verificationId;

  @override
  Future<UserModel?> signInWithGoogle() async {
    await _googleSignIn.signOut();

    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _auth.signInWithCredential(credential);

    return UserModel.fromFirebase(userCredential.user);
  }

  @override
  Future<void> signInWithPhone(String phone) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (e) {
        throw Exception(e.message);
      },
      codeSent: (verificationId, _) {
        _verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  @override
  Future<UserModel?> verifyOtp(String verificationId, String otp) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );

    final userCredential = await _auth.signInWithCredential(credential);
    return UserModel.fromFirebase(userCredential.user);
  }

  String? get verificationId => _verificationId;

  @override
  Future<void> logOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
