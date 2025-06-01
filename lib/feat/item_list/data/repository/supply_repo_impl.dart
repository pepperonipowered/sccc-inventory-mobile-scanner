import 'package:dartz/dartz.dart';
import 'package:logger/web.dart';
import 'package:sccc_v3/feat/item_list/data/model/paginated_supply_result.dart';
import 'package:sccc_v3/feat/item_list/data/model/supply_query_params_req.dart';
import 'package:sccc_v3/feat/item_list/data/model/supply_model.dart';
import 'package:sccc_v3/feat/item_list/data/source/supply_service.dart';
import 'package:sccc_v3/feat/item_list/domain/entity/supply_entity.dart';
import 'package:sccc_v3/feat/item_list/domain/repository/supply_repo.dart';
import 'package:sccc_v3/service_locator.dart';

class SupplyRepoImpl implements SupplyRepo {
  @override
  Future<Either<dynamic, PaginatedSupplyResult>> getAllSupplies(SupplyQueryParamsReq param) async {
    Either result = await getIt<SupplyService>().getAllSupplies(param);

    return result.fold((error) => Left(error), (response) {
      try {
        final body = response.data['data'];
        final rawList = body['data'] as List<dynamic>;

        final List<SupplyModel> supplyModels = rawList.map<SupplyModel>((item) => SupplyModel.fromMap(item)).toList();

        final supplyEntities = supplyModels.map((e) => e.toEntity()).toList();

        final paginated = PaginatedSupplyResult(
          data: supplyEntities,
          currentPage: body['current_page'] ?? 1,
          lastPage: body['last_page'] ?? 1,
          total: body['total'] ?? 0,
        );

        getIt<Logger>().i('SupplyRepoImpl: ${supplyEntities.length} items on page ${paginated.currentPage}');
        return Right(paginated);
      } catch (e) {
        getIt<Logger>().e('SupplyRepoImpl: Failed to parse response', error: e);
        return Left('Invalid response format');
      }
    });
  }

  @override
  Future<Either<dynamic, SupplyEntity>> getSupplyById(int id) async {
    Either result = await getIt<SupplyService>().getSupplyById(id);
    return result.fold((error) => Left(error), (response) {
      try {
        final body = response.data['data'];
        final supplyModel = SupplyModel.fromMap(body);
        final supplyEntity = supplyModel.toEntity();

        getIt<Logger>().i('SupplyRepoImpl: Fetched supply with ID $id');
        return Right(supplyEntity);
      } catch (e) {
        getIt<Logger>().e('SupplyRepoImpl: Failed to parse response for ID $id', error: e);
        return Left('Invalid response format');
      }
    });
  }
}
