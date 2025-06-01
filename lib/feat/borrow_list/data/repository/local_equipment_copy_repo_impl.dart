import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import 'package:sccc_v3/feat/borrow_list/data/source/local_equipment_service.dart';
import 'package:sccc_v3/feat/borrow_list/domain/entities/local_equipment_copy_entity.dart';
import 'package:sccc_v3/feat/borrow_list/domain/repository/local_equipment_copy_repo.dart';
import 'package:sccc_v3/service_locator.dart';

class LocalEquipmentCopyRepoImpl implements LocalEquipmentCopyRepo {
  @override
  Future<void> addEquipmentCopy(LocalEquipmentCopyEntity equipmentCopy) async {
    try {
      await getIt<LocalEquipmentCopyService>().addEquipmentCopy(equipmentCopy);
      getIt<Logger>().d('Equipment copy added successfully local Equipment repo impl');
    } catch (error) {
      getIt<Logger>().e('Equipment copy add failed local Equipment repo impl: $error');
      rethrow;
    }
  }

  @override
  Future<List<LocalEquipmentCopyEntity>> getAllEquipmentCopies() async {
    Either result = await getIt<LocalEquipmentCopyService>().getAllEquipmentCopies();

    return result.fold(
      (error) {
        getIt<Logger>().e('Get all equipment copies failed local equipment repo impl: $error');
        throw Exception(error);
      }, // Handle error by throwing an exception
      (data) {
        getIt<Logger>().d('Get all equipment copies successfully local equipment repo impl: $data');
        return data as List<LocalEquipmentCopyEntity>;
      }, // return void
    );
  }

  @override
  Future<void> deleteEquipmentCopy(LocalEquipmentCopyEntity equipmentCopy) async {
    try {
      await getIt<LocalEquipmentCopyService>().deleteEquipmentCopy(equipmentCopy);
      getIt<Logger>().d('Equipment copy deleted successfully local Equipment repo impl');
    } catch (error) {
      getIt<Logger>().e('Equipment copy deletion failed local Equipment repo impl: $error');
      rethrow;
    }
  }
}
