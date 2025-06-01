import 'dart:convert';

import 'package:sccc_v3/feat/item_list/data/model/category_model.dart';
import 'package:sccc_v3/feat/item_list/data/model/equipment_model.dart';
import 'package:sccc_v3/feat/item_list/domain/entity/equipment_copy_entity.dart';

class EquipmentCopyModel {
  final int id;
  final int itemId;
  final bool isAvailable;
  final int copyNum;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final EquipmentModel officeEquipment;
  final CategoryModel categories;

  EquipmentCopyModel({
    required this.id,
    required this.itemId,
    required this.isAvailable,
    required this.copyNum,
    this.createdAt,
    this.updatedAt,
    required this.officeEquipment,
    required this.categories,
  });

  factory EquipmentCopyModel.fromMap(Map<String, dynamic> map) {
    final officeEquipmentMap = map['office_equipments'] as Map<String, dynamic>;
    final categoryMap = officeEquipmentMap['categories'] as Map<String, dynamic>?;

    if (categoryMap == null) {
      throw Exception("Missing 'categories' in 'office_equipments'");
    }

    return EquipmentCopyModel(
      id: map['id'],
      itemId: map['item_id'],
      isAvailable: map['is_available'] == 1,
      copyNum: map['copy_num'],
      createdAt: map['created_at'] != null ? DateTime.tryParse(map['created_at']) : null,
      updatedAt: map['updated_at'] != null ? DateTime.tryParse(map['updated_at']) : null,
      officeEquipment: EquipmentModel.fromMap(officeEquipmentMap),
      categories: CategoryModel.fromMap(categoryMap),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'item_id': itemId,
      'is_available': isAvailable ? 1 : 0,
      'copy_num': copyNum,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'office_equipments': officeEquipment.toMap(),
      'categories': categories.toMap(),
    };
  }

  factory EquipmentCopyModel.fromJson(String source) => EquipmentCopyModel.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}

extension EquipmentCopyModelExtension on EquipmentCopyModel {
  EquipmentCopyEntity toEntity() => EquipmentCopyEntity(
    id: id,
    itemId: itemId,
    isAvailable: isAvailable,
    copyNum: copyNum,
    createdAt: createdAt,
    updatedAt: updatedAt,
    officeEquipment: officeEquipment.toEntity(),
    categories: categories.toEntity(),
  );
}
