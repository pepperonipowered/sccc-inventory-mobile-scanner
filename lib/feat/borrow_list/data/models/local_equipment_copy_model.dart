import 'package:drift/drift.dart';
import 'package:sccc_v3/core/database/database.dart';
import 'package:sccc_v3/feat/borrow_list/domain/entities/local_equipment_copy_entity.dart';

class LocalEquipmentCopyModel {
  final LocalEquipmentCopyEntity entity;

  LocalEquipmentCopyModel(this.entity);

  factory LocalEquipmentCopyModel.fromData(EquipmentCopyData data) {
    return LocalEquipmentCopyModel(
      LocalEquipmentCopyEntity(
        localId: data.localId,
        id: data.id,
        itemId: data.itemId,
        isAvailable: data.isAvailable,
        copyNum: data.copyNum,
        createdAt: data.createdAt,
        updatedAt: data.updatedAt,
        equipmentId: data.equipmentId,
        equipmentName: data.equipmentName,
        equipmentDescription: data.equipmentDescription,
        categoryId: data.categoryId,
        categoryName: data.categoryName,
      ),
    );
  }

  EquipmentCopyCompanion toCompanion() {
    return EquipmentCopyCompanion(
      // dont need local id here
      id: Value(entity.id),
      itemId: Value(entity.itemId),
      isAvailable: Value(entity.isAvailable),
      copyNum: Value(entity.copyNum),
      createdAt: Value(entity.createdAt),
      updatedAt: Value(entity.updatedAt),
      equipmentId: Value(entity.equipmentId),
      equipmentName: Value(entity.equipmentName),
      equipmentDescription: Value(entity.equipmentDescription),
      categoryId: Value(entity.categoryId),
      categoryName: Value(entity.categoryName),
    );
  }

  factory LocalEquipmentCopyModel.fromEntity(LocalEquipmentCopyEntity entity) {
    return LocalEquipmentCopyModel(entity);
  }

  LocalEquipmentCopyEntity toEntity() {
    return entity;
  }
}
