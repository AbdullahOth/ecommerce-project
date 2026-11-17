class User {
  final String id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final bool isVerified;
  final String? avatarUrl;
  final DateTime? createdAt;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    this.isVerified = false,
    this.avatarUrl,
    this.createdAt,
  });
}