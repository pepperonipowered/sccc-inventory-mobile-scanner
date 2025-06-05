import 'package:sccc_v3/feat/borrow_list/domain/entities/local_equipment_copy_entity.dart';
import 'package:sccc_v3/feat/borrow_list/domain/entities/local_item_entity.dart';
import 'package:sccc_v3/feat/borrow_list/domain/entities/local_supply_entity.dart';
import 'package:sccc_v3/feat/borrow_list/domain/repository/local_equipment_copy_repo.dart';
import 'package:sccc_v3/feat/borrow_list/domain/repository/local_item_repo.dart';
import 'package:sccc_v3/feat/borrow_list/domain/repository/local_supply_repo.dart';
import 'package:sccc_v3/service_locator.dart';

class LocalItemRepoImpl implements LocalItemRepo {
  @override
  Future<List<LocalItemEntity>> getAllItems() async {
    final supplies = await getIt<LocalSupplyRepo>().getAllSupplies();
    final equipmentCopies = await getIt<LocalEquipmentCopyRepo>().getAllEquipmentCopies();

    final items = [...supplies, ...equipmentCopies];

    return items.cast<LocalItemEntity>();
  }

  @override
  Future<void> deleteItem(LocalItemEntity localItem) async {
    if (localItem is LocalSupplyEntity) {
      await getIt<LocalSupplyRepo>().deleteSupply(localItem);
    } else if (localItem is LocalEquipmentCopyEntity) {
      await getIt<LocalEquipmentCopyRepo>().deleteEquipmentCopy(localItem);
    }
  }

  @override
  Future<void> addItem(LocalItemEntity localItem) async {
    if (localItem is LocalSupplyEntity) {
      await getIt<LocalSupplyRepo>().addSupply(localItem);
    } else if (localItem is LocalEquipmentCopyEntity) {
      await getIt<LocalEquipmentCopyRepo>().addEquipmentCopy(localItem);
    }
  }
}
