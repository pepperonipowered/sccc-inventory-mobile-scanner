import 'package:dartz/dartz.dart';
import 'package:sccc_v3/core/database/database.dart';
import 'package:sccc_v3/feat/borrow_list/data/models/local_equipment_copy_model.dart';
import 'package:sccc_v3/feat/borrow_list/domain/entities/local_equipment_copy_entity.dart';
import 'package:sccc_v3/service_locator.dart';

abstract class LocalEquipmentCopyService {
  Future<void> addEquipmentCopy(LocalEquipmentCopyEntity equipmentCopy);
  Future<Either> getAllEquipmentCopies();
  Future<void> deleteEquipmentCopy(LocalEquipmentCopyEntity equipmentCopy);
}

class LocalEquipmentServiceImpl implements LocalEquipmentCopyService {
  @override
  Future<void> addEquipmentCopy(LocalEquipmentCopyEntity equipmentCopy) async {
    final db = getIt<AppDatabase>();

    // Check if a record with the same ID already exists
    final existing =
        await (db.select(db.equipmentCopy)
              ..where((tbl) => tbl.itemId.equals(equipmentCopy.itemId))
              ..where((tbl) => tbl.copyNum.equals(equipmentCopy.copyNum)))
            .getSingleOrNull();

    if (existing != null) {
      throw 'This equipment copy is already in the borrow list.';
    }
    // If not exists, insert
    final model = LocalEquipmentCopyModel.fromEntity(equipmentCopy);
    await db.into(db.equipmentCopy).insert(model.toCompanion());
  }

  @override
  Future<Either> getAllEquipmentCopies() async {
    try {
      final db = getIt<AppDatabase>();
      final equipmentCopies = await db.select(db.equipmentCopy).get();
      final entities = equipmentCopies.map((row) => LocalEquipmentCopyModel.fromData(row).toEntity()).toList();
      return Right(entities);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<void> deleteEquipmentCopy(LocalEquipmentCopyEntity equipmentCopy) async {
    final db = getIt<AppDatabase>();
    final equipmentId = equipmentCopy.equipmentId;
    final copyNumber = equipmentCopy.copyNum;
    // Check if a record with the same ID already exists
    final existing =
        await (db.select(db.equipmentCopy)
              ..where((tbl) => tbl.itemId.equals(equipmentCopy.itemId))
              ..where((tbl) => tbl.copyNum.equals(equipmentCopy.copyNum)))
            .getSingleOrNull();

    if (existing == null) {
      throw 'This equipment copy does not exist in the borrow list.';
    }

    await (db.delete(db.equipmentCopy)
      ..where((tbl) => tbl.itemId.equals(equipmentId))
      ..where((tbl) => tbl.copyNum.equals(copyNumber))).go();
  }
}
