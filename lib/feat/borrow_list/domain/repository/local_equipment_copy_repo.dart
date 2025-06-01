import 'package:sccc_v3/feat/borrow_list/domain/entities/local_equipment_copy_entity.dart';

abstract class LocalEquipmentCopyRepo {
  Future<void> addEquipmentCopy(LocalEquipmentCopyEntity equipmentCopy);
  Future<List<LocalEquipmentCopyEntity>> getAllEquipmentCopies();
  Future<void> deleteEquipmentCopy(LocalEquipmentCopyEntity equipmentCopy);
}
