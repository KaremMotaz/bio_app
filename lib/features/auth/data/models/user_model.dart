import '../../domain/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.email,
    required super.uid,
    super.firstName,
    super.lastName,
    super.imageUrl,
    super.phoneNumber,
    super.grade,
    super.role,
    super.oldUser,
    super.isPremiumUser,
  });

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      // name: user.displayName ?? '',
      email: user.email ?? '',
      uid: user.uid,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json["email"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      imageUrl: json["imageUrl"],
      phoneNumber: json["phoneNumber"],
      grade: json["grade"],
      role: json["role"],
      oldUser: json["oldUser"],
      uid: json["uid"],
      isPremiumUser: json["isPremiumUser"],
    );
  }

  factory UserModel.fromEntity(UserEntity student) {
    return UserModel(
      email: student.email,
      firstName: student.firstName,
      lastName: student.lastName,
      imageUrl: student.imageUrl,
      phoneNumber: student.phoneNumber,
      grade: student.grade,
      role: student.role,
      oldUser: student.oldUser,
      isPremiumUser: student.isPremiumUser,
      uid: student.uid,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber,
      'grade': grade,
      'role': role,
      'oldUser': oldUser,
      'isPremiumUser': isPremiumUser,
      'uid': uid,
    };
  }
}
