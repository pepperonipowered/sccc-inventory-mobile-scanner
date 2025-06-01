import 'package:drift/drift.dart';
import 'package:sccc_v3/core/database/database.dart';
import 'package:sccc_v3/feat/borrow_list/domain/entities/local_supply_entity.dart';

class LocalSupplyModel {
  final LocalSupplyEntity entity;

  LocalSupplyModel(this.entity);

  factory LocalSupplyModel.fromData(Supply data) {
    return LocalSupplyModel(
      LocalSupplyEntity(
        localId: data.localId,
        id: data.id,
        supplyName: data.supplyName,
        supplyDescription: data.supplyDescription,
        serialNumber: data.serialNumber,
        categoryId: data.categoryId,
        supplyQuantity: data.supplyQuantity,
        imagePath: data.imagePath,
        createdAt: data.createdAt,
        updatedAt: data.updatedAt,
        categoryName: data.categoryName,
      ),
    );
  }

  SuppliesCompanion toCompanion() {
    return SuppliesCompanion(
      id: Value(entity.id),
      supplyName: Value(entity.supplyName),
      supplyDescription: Value(entity.supplyDescription),
      serialNumber: Value(entity.serialNumber),
      categoryId: Value(entity.categoryId),
      supplyQuantity: Value(entity.supplyQuantity),
      imagePath: Value(entity.imagePath),
      createdAt: Value(entity.createdAt),
      updatedAt: Value(entity.updatedAt),
      categoryName: Value(entity.categoryName),
    );
  }

  factory LocalSupplyModel.fromEntity(LocalSupplyEntity entity) {
    return LocalSupplyModel(entity);
  }

  LocalSupplyEntity toEntity() {
    return entity;
  }
}
