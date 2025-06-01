import 'dart:convert';

import 'package:sccc_v3/feat/item_list/domain/entity/office_equipment_entity.dart';

class EquipmentModel {
  int id;
  String? equipmentName;
  String? equipmentDescription;
  int categoryId;
  String? imagePath;
  DateTime? createdAt;
  DateTime? updatedAt;

  EquipmentModel({
    required this.id,
    this.equipmentName,
    this.equipmentDescription,
    required this.categoryId,
    this.imagePath,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'equipmentName': equipmentName,
      'equipmentDescription': equipmentDescription,
      'categoryId': categoryId,
      'imagePath': imagePath,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory EquipmentModel.fromMap(Map<String, dynamic> map) {
    return EquipmentModel(
      id: map['id'],
      equipmentName: map['equipment_name'],
      equipmentDescription: map['equipment_description'],
      categoryId: map['category_id'],
      imagePath: map['image_path'],
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      updatedAt: map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EquipmentModel.fromJson(String source) => EquipmentModel.fromMap(json.decode(source));
}

extension OfficeEquipmentModelExtension on EquipmentModel {
  OfficeEquipmentEntity toEntity() => OfficeEquipmentEntity(
    id: id,
    equipmentName: equipmentName,
    equipmentDescription: equipmentDescription,
    categoryId: categoryId,
    imagePath: imagePath,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
