import '../../../../core/theming/app_colors.dart';
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
    super.scoreThisDay,
    super.scoreThisWeek,
    super.scoreThisMonth,
  });

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(email: user.email ?? '', uid: user.uid);
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json["email"] ?? '',
      firstName: json["firstName"],
      lastName: json["lastName"],
      imageUrl: json["imageUrl"],
      phoneNumber: json["phoneNumber"],
      oldUser: json["oldUser"],
      uid: json["uid"] ?? '',
      isPremiumUser: json["isPremiumUser"],
      avatarColor: json["avatarColor"],
      scoreThisDay: (json["scoreThisDay"] as num?)?.toDouble(),
      scoreThisMonth: (json["scoreThisMonth"] as num?)?.toDouble(),
      scoreThisWeek: (json["scoreThisWeek"] as num?)?.toDouble(),
      createdAt: (json['createdAt'] is Timestamp)
          ? (json['createdAt'] as Timestamp).toDate()
          : (json['createdAt'] is String)
          ? DateTime.tryParse(json['createdAt'])
          : null,
    );
  }

  /// من الـ Entity
  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      email: user.email,
      firstName: user.firstName,
      lastName: user.lastName,
      imageUrl: user.imageUrl,
      phoneNumber: user.phoneNumber,
      oldUser: user.oldUser,
      isPremiumUser: user.isPremiumUser,
      uid: user.uid,
      avatarColor: user.avatarColor,
      createdAt: user.createdAt,
      scoreThisDay: user.scoreThisDay ?? 0.0,
      scoreThisMonth: user.scoreThisMonth ?? 0.0,
      scoreThisWeek: user.scoreThisWeek ?? 0.0,
    );
  }

  final Color color = AppColors.getRandomColor();

  Map<String, dynamic> toFirestoreMap() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'oldUser': oldUser,
      'isPremiumUser': isPremiumUser,
      'uid': uid,
      'imageUrl': imageUrl,
      'avatarColor': avatarColor ?? color.toARGB32(),
      'createdAt': FieldValue.serverTimestamp(),
      'scoreThisDay': scoreThisDay ?? 0.0,
      'scoreThisMonth': scoreThisMonth ?? 0.0,
      'scoreThisWeek': scoreThisWeek ?? 0.0,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'oldUser': oldUser,
      'isPremiumUser': isPremiumUser,
      'uid': uid,
      'imageUrl': imageUrl,
      'avatarColor': avatarColor ?? color.toARGB32(),
      'createdAt': createdAt?.toIso8601String(),
      'scoreThisDay': scoreThisDay ?? 0.0,
      'scoreThisMonth': scoreThisMonth ?? 0.0,
      'scoreThisWeek': scoreThisWeek ?? 0.0,
    };
  }
}
