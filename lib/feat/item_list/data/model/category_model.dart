import 'dart:convert';

import 'package:sccc_v3/feat/item_list/domain/entity/category_entity.dart';

class CategoryModel {
  final int id;
  final String categoryName;
  final bool isDeleted;
  final int? deletedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CategoryModel({
    required this.id,
    required this.categoryName,
    required this.isDeleted,
    required this.deletedBy,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryName': categoryName,
      'isDeleted': isDeleted,
      'deletedBy': deletedBy,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as int,
      categoryName: map['category_name'] as String,
      isDeleted: map['is_deleted'] == 1,
      deletedBy: map['deleted_by'] as int?,
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at'] as String) : null,
      updatedAt: map['updated_at'] != null ? DateTime.parse(map['updated_at'] as String) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) => CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

extension CategoryModelExtension on CategoryModel {
  CategoryEntity toEntity() => CategoryEntity(
    id: id,
    categoryName: categoryName,
    isDeleted: isDeleted,
    deletedBy: deletedBy,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
