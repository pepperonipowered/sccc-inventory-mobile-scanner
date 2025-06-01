import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import 'package:sccc_v3/feat/borrow_list/data/models/local_supply_model.dart';
import 'package:sccc_v3/feat/borrow_list/data/source/local_supply_service.dart';
import 'package:sccc_v3/feat/borrow_list/domain/entities/local_supply_entity.dart';
import 'package:sccc_v3/feat/borrow_list/domain/repository/local_supply_repo.dart';
import 'package:sccc_v3/service_locator.dart';

class LocalSupplyRepoImpl implements LocalSupplyRepo {
  @override
  Future<void> addSupply(LocalSupplyEntity localSupply) async {
    try {
      await getIt<LocalSupplyService>().addSupply(localSupply);
      getIt<Logger>().d('Supply copy added successfully local Supply repo impl');
    } catch (error) {
      getIt<Logger>().e('Supply copy add failed local Supply repo impl: $error');
      rethrow;
    }
  }

  @override
  Future<List<LocalSupplyEntity>> getAllSupplies() async {
    Either result = await getIt<LocalSupplyService>().getAllSupplies();

    return result.fold(
      (error) {
        getIt<Logger>().e('Get all supplies failed local Supply repo impl: $error');
        throw error;
      }, // Handle error by throwing an exception
      (data) {
        getIt<Logger>().d('Get all supplies successfully local Supply repo impl: $data');
        return (data as List<LocalSupplyModel>).map((model) => model.toEntity()).toList();
      },
    );
  }

  @override
  Future<void> deleteSupply(LocalSupplyEntity localSupply) async {
    try {
      await getIt<LocalSupplyService>().deleteSupply(localSupply);
      getIt<Logger>().d('Supply successfully deleted local at Supply repo impl');
    } catch (error) {
      getIt<Logger>().e('Supply deletion failed local Supply at Supply repo impl: $error');
      rethrow;
    }
  }

  @override
  Future<void> updateSupply(LocalSupplyEntity localSupply) async {
    try {
      await getIt<LocalSupplyService>().updateSupply(localSupply);
      getIt<Logger>().d('Supply copy updated successfully local Supply repo impl');
    } catch (error) {
      getIt<Logger>().e('Supply copy update failed local Supply repo impl: $error');
      rethrow;
    }
  }
}
