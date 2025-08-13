import 'package:bio_app/core/theming/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../domain/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.email,
    required super.uid,
    super.firstName,
    super.lastName,
    super.imageUrl,
    super.phoneNumber,
    super.oldUser,
    super.isPremiumUser,
    super.avatarColor,
    super.createdAt,
  });

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(email: user.email ?? '', uid: user.uid);
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json["email"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      imageUrl: json["imageUrl"],
      phoneNumber: json["phoneNumber"],
      oldUser: json["oldUser"],
      uid: json["uid"],
      isPremiumUser: json["isPremiumUser"],
      avatarColor: json["avatarColor"],
      createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  factory UserModel.fromEntity(UserEntity student) {
    return UserModel(
      email: student.email,
      firstName: student.firstName,
      lastName: student.lastName,
      imageUrl: student.imageUrl,
      phoneNumber: student.phoneNumber,
      oldUser: student.oldUser,
      isPremiumUser: student.isPremiumUser,
      uid: student.uid,
      avatarColor: student.avatarColor,
      createdAt: student.createdAt,
    );
  }
  final Color color = AppColors.getRandomColor();

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'oldUser': oldUser,
      'isPremiumUser': isPremiumUser,
      'uid': uid,
      'imageUrl': imageUrl,
      'avatarColor': color.toARGB32(),
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
