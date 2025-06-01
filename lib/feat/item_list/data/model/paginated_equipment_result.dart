import 'package:sccc_v3/feat/item_list/domain/entity/equipment_copy_entity.dart';

class PaginatedEquipmentResult {
  final List<EquipmentCopyEntity> data;
  final int currentPage;
  final int lastPage;
  final int total;

  PaginatedEquipmentResult({
    required this.data,
    required this.currentPage,
    required this.lastPage,
    required this.total,
  });
}
