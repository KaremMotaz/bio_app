class UserEntity {
  final String? email;
  final String? uid;
  final String? imageUrl;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final bool oldUser;
  final bool isPremiumUser;
  final int? avatarColor;
  final DateTime? createdAt;
  final double? scoreThisDay;
  final double? scoreThisMonth;
  final double? scoreThisWeek;
  final String? lastDayResetKey;
  final String? lastWeekResetKey;
  final String? lastMonthResetKey;
  final int? rank;

  UserEntity({
    this.email,
    this.uid,
    this.imageUrl,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.oldUser = false,
    this.isPremiumUser = false,
    this.avatarColor,
    this.createdAt,
    this.scoreThisDay,
    this.scoreThisMonth,
    this.scoreThisWeek,
    this.rank,
    this.lastDayResetKey,
    this.lastWeekResetKey,
    this.lastMonthResetKey,
  });
}

// user_entity_copy.dart
extension UserEntityX on UserEntity {
  UserEntity copyWith({
    String? email,
    String? uid,
    String? imageUrl,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    bool? oldUser,
    bool? isPremiumUser,
    int? avatarColor,
    DateTime? createdAt,
    double? scoreThisDay,
    double? scoreThisWeek,
    double? scoreThisMonth,
    int? rank,
    String? lastDayResetKey,
    String? lastWeekResetKey,
    String? lastMonthResetKey,
  }) {
    return UserEntity(
      email: email ?? this.email,
      uid: uid ?? this.uid,
      imageUrl: imageUrl ?? this.imageUrl,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      oldUser: oldUser ?? this.oldUser,
      isPremiumUser: isPremiumUser ?? this.isPremiumUser,
      avatarColor: avatarColor ?? this.avatarColor,
      createdAt: createdAt ?? this.createdAt,
      scoreThisDay: scoreThisDay ?? this.scoreThisDay,
      scoreThisWeek: scoreThisWeek ?? this.scoreThisWeek,
      scoreThisMonth: scoreThisMonth ?? this.scoreThisMonth,
      rank: rank ?? this.rank,
      lastDayResetKey: lastDayResetKey ?? this.lastDayResetKey,
      lastWeekResetKey: lastWeekResetKey ?? this.lastWeekResetKey,
      lastMonthResetKey: lastMonthResetKey ?? this.lastMonthResetKey,
    );
  }
}
