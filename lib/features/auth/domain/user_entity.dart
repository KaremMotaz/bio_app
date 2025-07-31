class UserEntity {
  final String? email;
  final String? uid;
  final String? imageUrl;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? grade;
  final String role;
  final bool oldUser;
  final bool isPremiumUser;

  UserEntity({
    this.email,
    this.uid,
    this.imageUrl,
    this.firstName,
    this.lastName,
    this.grade,
    this.phoneNumber,
    this.role = 'Student',
    this.oldUser = false,
    this.isPremiumUser = false,
  });
}
