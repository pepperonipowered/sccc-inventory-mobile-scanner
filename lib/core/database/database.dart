import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sccc_v3/service_locator.dart';

part 'database.g.dart';

class LocalUser extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))(); // Always 1
  TextColumn get token => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class EquipmentCopy extends Table {
  IntColumn get localId => integer().autoIncrement()();
  // Equipment Copy Fields
  IntColumn get id => integer()();
  IntColumn get itemId => integer()();
  BoolColumn get isAvailable => boolean().withDefault(const Constant(true))();
  IntColumn get copyNum => integer()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  // Office Equipment Fields (flattened)
  IntColumn get equipmentId => integer()(); // same as itemId, optional redundancy
  TextColumn get equipmentName => text()(); // assuming at least a name exists
  TextColumn get equipmentDescription => text().nullable()(); // if it exists
  TextColumn get imagePath => text().nullable()();
  IntColumn get categoryId => integer()();

  // Category Fields (flattened)
  TextColumn get categoryName => text()();
}

class Supplies extends Table {
  IntColumn get localId => integer().autoIncrement()();
  IntColumn get id => integer()();
  TextColumn get supplyName => text().nullable()();
  TextColumn get supplyDescription => text().nullable()();
  TextColumn get serialNumber => text().nullable()();
  IntColumn get supplyQuantity => integer().nullable()();
  TextColumn get imagePath => text().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  // Flattened category fields
  IntColumn get categoryId => integer().nullable()();
  TextColumn get categoryName => text().nullable()();
}

@DriftDatabase(tables: [LocalUser, EquipmentCopy, Supplies])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'sccc_mobile_db',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }

  Future<void> deleteDatabaseFile() async {
    final dir = await getApplicationSupportDirectory();
    final dbFile = File('${dir.path}/sccc_mobile_db.sqlite');
    if (await dbFile.exists()) {
      await dbFile.delete();
      getIt<Logger>().i('✅ Database file deleted: ${dbFile.path}');
    } else {
      getIt<Logger>().w('⚠️ No DB file found to delete at: ${dbFile.path}');
    }
  }

  Future<void> printAllTables() async {
    final logger = getIt<Logger>();

    // Print LocalUser table
    final users = await select(localUser).get();
    logger.i('--- LocalUser Table ---');
    for (final user in users) {
      logger.i('User: id=${user.id}, token=${user.token}');
    }

    // Print EquipmentCopy table
    final equipmentCopies = await select(equipmentCopy).get();
    logger.i('--- EquipmentCopy Table ---');
    for (final copy in equipmentCopies) {
      logger.i(
        'Copy: '
        'localId=${copy.localId}, '
        'id=${copy.id}, itemId=${copy.itemId}, isAvailable=${copy.isAvailable}, copyNum=${copy.copyNum}, '
        'createdAt=${copy.createdAt}, updatedAt=${copy.updatedAt}, '
        'equipmentId=${copy.equipmentId}, equipmentName=${copy.equipmentName}, '
        'equipmentDescription=${copy.equipmentDescription}, '
        'categoryId=${copy.categoryId}, categoryName=${copy.categoryName}',
      );
    }

    // Print Supplies table
    final suppliesList = await select(supplies).get();
    logger.i('--- Supplies Table ---');
    for (final supply in suppliesList) {
      logger.i(
        'Supply: '
        'localId=${supply.localId}, '
        'id=${supply.id}, name=${supply.supplyName}, desc=${supply.supplyDescription}, '
        'serial=${supply.serialNumber}, quantity=${supply.supplyQuantity}, '
        'catId=${supply.categoryId}, catName=${supply.categoryName}, '
        'imagePath=${supply.imagePath}, '
        'createdAt=${supply.createdAt}, updatedAt=${supply.updatedAt}',
      );
    }
  }
}
