class UserEntity {
  final int id;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String email;
  final DateTime? emailVerifiedAt;
  final bool? for911;
  final bool? forInventory;
  final int? role;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? token;

  UserEntity({
    required this.id,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.email,
    this.emailVerifiedAt,
    this.for911,
    this.forInventory,
    this.role,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.token,
  });
}
