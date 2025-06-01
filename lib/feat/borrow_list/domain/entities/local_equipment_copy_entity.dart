import 'package:sccc_v3/feat/borrow_list/domain/entities/local_item_entity.dart';

class LocalEquipmentCopyEntity extends LocalItemEntity {
  final int? localId;
  final int id;
  final int itemId;
  final bool isAvailable;
  final int copyNum;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int equipmentId;
  final String equipmentName;
  final String? equipmentDescription;
  final int categoryId;
  final String categoryName;

  LocalEquipmentCopyEntity({
    this.localId,
    required this.id,
    required this.itemId,
    required this.isAvailable,
    required this.copyNum,
    this.createdAt,
    this.updatedAt,
    required this.equipmentId,
    required this.equipmentName,
    this.equipmentDescription,
    required this.categoryId,
    required this.categoryName,
  });
}
