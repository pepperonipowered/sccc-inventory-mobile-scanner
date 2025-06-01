import 'package:sccc_v3/feat/item_list/domain/entity/category_entity.dart';
import 'package:sccc_v3/feat/item_list/domain/entity/office_equipment_entity.dart';

class EquipmentCopyEntity {
  final int id;
  final int itemId;
  final bool isAvailable;
  final int copyNum;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final OfficeEquipmentEntity officeEquipment;
  final CategoryEntity categories;

  EquipmentCopyEntity({
    required this.id,
    required this.itemId,
    required this.isAvailable,
    required this.copyNum,
    this.createdAt,
    this.updatedAt,
    required this.officeEquipment,
    required this.categories,
  });
}
