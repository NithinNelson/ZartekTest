import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.uid,
    super.name,
    super.email,
    super.phone,
  });

  factory UserModel.fromFirebase(user) {
    return UserModel(
      uid: user.uid,
      name: user.displayName,
      email: user.email,
      phone: user.phoneNumber,
    );
  }
}
