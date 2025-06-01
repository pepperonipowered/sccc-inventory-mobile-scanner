import 'dart:convert';

import 'package:sccc_v3/feat/auth/domain/entity/user_entity.dart';

class UserModel {
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

  UserModel({
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'middle_name': middleName,
      'last_name': lastName,
      'email': email,
      'email_verified_at': emailVerifiedAt?.toIso8601String(),
      'for_911': (for911 ?? false) ? 1 : 0,
      'for_inventory': (forInventory ?? false) ? 1 : 0,
      'role': role,
      'is_deleted': (isDeleted ?? false) ? 1 : 0,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] is int ? map['id'] as int : int.tryParse(map['id'].toString()) ?? 0,
      firstName: map['firstName'] as String? ?? '',
      middleName: map['middleName'] as String?,
      lastName: map['lastName'] as String? ?? '',
      email: map['email'] as String? ?? '',
      emailVerifiedAt:
          map['email_verified_at'] != null && (map['email_verified_at'] as String).isNotEmpty
              ? DateTime.tryParse(map['email_verified_at'] as String)
              : null,
      for911: map['for_911'] == null ? null : (map['for_911'] == 1),
      forInventory: map['for_inventory'] == null ? null : (map['for_inventory'] == 1),
      role:
          map['role'] != null ? (map['role'] is int ? map['role'] as int : int.tryParse(map['role'].toString())) : null,
      isDeleted: map['is_deleted'] == null ? null : (map['is_deleted'] == 1),
      createdAt:
          map['created_at'] != null && (map['created_at'] as String).isNotEmpty
              ? DateTime.tryParse(map['created_at'] as String)
              : null,
      updatedAt:
          map['updated_at'] != null && (map['updated_at'] as String).isNotEmpty
              ? DateTime.tryParse(map['updated_at'] as String)
              : null,
      token: map['token'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

extension UserModelExtension on UserModel {
  UserEntity toEntity() => UserEntity(
    id: id,
    firstName: firstName,
    middleName: middleName,
    lastName: lastName,
    email: email,
    emailVerifiedAt: emailVerifiedAt,
    for911: for911,
    forInventory: forInventory,
    role: role,
    isDeleted: isDeleted,
    createdAt: createdAt,
    updatedAt: updatedAt,
    token: token,
  );
}
