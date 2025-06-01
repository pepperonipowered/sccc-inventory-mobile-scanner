import 'package:sccc_v3/feat/borrow_list/domain/entities/local_supply_entity.dart';

abstract class LocalSupplyRepo {
  Future<List<LocalSupplyEntity>> getAllSupplies();
  Future<void> addSupply(LocalSupplyEntity localSupply);
  Future<void> updateSupply(LocalSupplyEntity localSupply);
  Future<void> deleteSupply(LocalSupplyEntity localSupply);
}
