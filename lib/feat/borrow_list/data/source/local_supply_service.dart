import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:sccc_v3/core/database/database.dart';
import 'package:sccc_v3/feat/borrow_list/data/models/local_supply_model.dart';
import 'package:sccc_v3/feat/borrow_list/domain/entities/local_supply_entity.dart';
import 'package:sccc_v3/service_locator.dart';

abstract class LocalSupplyService {
  Future<Either> getAllSupplies();
  Future<void> addSupply(LocalSupplyEntity supply);
  Future<void> updateSupply(LocalSupplyEntity supply);
  Future<void> deleteSupply(LocalSupplyEntity supply);
}

class LocalSupplyServiceImpl implements LocalSupplyService {
  @override
  Future<Either> getAllSupplies() async {
    final db = getIt<AppDatabase>();
    try {
      final supplies = await db.select(db.supplies).get();
      final models = supplies.map((row) => LocalSupplyModel.fromData(row)).toList();
      return Right(models);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<void> addSupply(LocalSupplyEntity supply) async {
    final db = getIt<AppDatabase>();
    final serial = supply.serialNumber;
    final id = supply.id;

    final existing =
        await (db.select(db.supplies)
          ..where((tbl) => tbl.id.equals(id) | tbl.serialNumber.equals(serial ?? ''))).getSingleOrNull();

    if (existing != null) {
      throw 'This supply is already in the borrow list.';
    }

    final model = LocalSupplyModel.fromEntity(supply);
    await db.into(db.supplies).insert(model.toCompanion());
  }

  @override
  Future<void> updateSupply(LocalSupplyEntity supply) async {
    final db = getIt<AppDatabase>();
    final serial = supply.serialNumber;
    final id = supply.id;

    final existing =
        await (db.select(db.supplies)
          ..where((tbl) => tbl.id.equals(id) | tbl.serialNumber.equals(serial ?? ''))).getSingleOrNull();

    if (existing == null) {
      throw ('This supply is not in the borrow list.');
    }

    final model = LocalSupplyModel.fromEntity(supply);
    await db.update(db.supplies).replace(model.toCompanion());
  }

  @override
  Future<void> deleteSupply(LocalSupplyEntity supply) async {
    final db = getIt<AppDatabase>();
    final serial = supply.serialNumber;
    final id = supply.id;

    final existing =
        await (db.select(db.supplies)
          ..where((tbl) => tbl.id.equals(id) | tbl.serialNumber.equals(serial ?? ''))).getSingleOrNull();

    if (existing == null) {
      throw ('This supply is not in the borrow list.');
    }

    await (db.delete(db.supplies)..where((tbl) => tbl.id.equals(id) & tbl.serialNumber.equals(serial ?? ''))).go();
  }
}
