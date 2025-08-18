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
  });
}
