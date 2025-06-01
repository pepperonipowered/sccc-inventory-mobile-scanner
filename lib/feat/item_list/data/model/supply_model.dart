import 'dart:convert';

import 'package:sccc_v3/feat/item_list/data/model/category_model.dart';
import 'package:sccc_v3/feat/item_list/domain/entity/supply_entity.dart';

class SupplyModel {
  final int id;
  final String? supplyName;
  final String? supplyDescription;
  final String? serialNumber;
  final int? categoryId;
  final int? supplyQuantity;
  final String? imagePath;
  final String? createdAt;
  final String? updatedAt;
  final CategoryModel categories;

  SupplyModel({
    required this.id,
    this.supplyName,
    this.supplyDescription,
    this.serialNumber,
    this.categoryId,
    this.supplyQuantity,
    this.imagePath,
    this.createdAt,
    this.updatedAt,
    required this.categories,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'supplyName': supplyName,
      'supplyDescription': supplyDescription,
      'serialNumber': serialNumber,
      'categoryId': categoryId,
      'supplyQuantity': supplyQuantity,
      'imagePath': imagePath,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'categories': categories.toMap(),
    };
  }

  factory SupplyModel.fromMap(Map<String, dynamic> map) {
    return SupplyModel(
      id: map['id'],
      supplyName: map['supply_name'],
      supplyDescription: map['supply_description'],
      serialNumber: map['serial_number'],
      categoryId: map['category_id'],
      supplyQuantity: map['supply_quantity'],
      imagePath: map['image_path'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      categories: CategoryModel.fromMap(map['categories']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SupplyModel.fromJson(String source) => SupplyModel.fromMap(json.decode(source));
}

extension OfficeSupplyModelExtension on SupplyModel {
  SupplyEntity toEntity() => SupplyEntity(
    id: id,
    supplyName: supplyName,
    supplyDescription: supplyDescription,
    serialNumber: serialNumber,
    categoryId: categoryId,
    supplyQuantity: supplyQuantity,
    imagePath: imagePath,
    createdAt: createdAt,
    updatedAt: updatedAt,
    categories: categories.toEntity(),
  );
}
