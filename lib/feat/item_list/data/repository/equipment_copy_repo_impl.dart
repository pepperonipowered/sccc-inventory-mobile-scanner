import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import 'package:sccc_v3/feat/item_list/data/model/equipment_copy_by_copy_num_and_item_id_req.dart';
import 'package:sccc_v3/feat/item_list/data/model/equipment_copy_model.dart';
import 'package:sccc_v3/feat/item_list/data/model/equipment_copy_query_params_req.dart';
import 'package:sccc_v3/feat/item_list/data/model/paginated_equipment_result.dart';
import 'package:sccc_v3/feat/item_list/data/source/equipment_service.dart';
import 'package:sccc_v3/feat/item_list/domain/entity/equipment_copy_entity.dart';
import 'package:sccc_v3/feat/item_list/domain/repository/equipment_copy_repo.dart';
import 'package:sccc_v3/service_locator.dart';

class EquipmentCopyRepoImpl implements EquipmentCopyRepo {
  @override
  Future<Either<dynamic, PaginatedEquipmentResult>> getEquipmentCopiesWithRelations(
    EquipmentCopyQueryParamsReq queryParams,
  ) async {
    Either result = await getIt<EquipmentCopyService>().getEquipmentCopiesWithRelations(queryParams);

    return result.fold((error) => Left(error), (response) {
      try {
        final body = response.data['data'];
        final rawList = body['data'] as List<dynamic>;

        final List<EquipmentCopyModel> equipmentModels =
            rawList.map<EquipmentCopyModel>((item) => EquipmentCopyModel.fromMap(item)).toList();

        final equipmentEntities = equipmentModels.map((e) => e.toEntity()).toList();

        final paginated = PaginatedEquipmentResult(
          data: equipmentEntities,
          currentPage: body['current_page'] ?? 1,
          lastPage: body['last_page'] ?? 1,
          total: body['total'] ?? 0,
        );

        getIt<Logger>().i('EquipmentCopyRepoImpl: ${equipmentEntities.length} items on page ${paginated.currentPage}');
        return Right(paginated);
      } catch (e) {
        getIt<Logger>().e('EquipmentCopyRepoImpl: Failed to parse response', error: e);
        return Left('Invalid response format');
      }
    });
  }

  @override
  Future<Either<dynamic, EquipmentCopyEntity>> getEquipmentCopyByItemAndCopyId(
    EquipmentCopyByCopyNumAndItemIdReq params,
  ) async {
    Either result = await getIt<EquipmentCopyService>().getEquipmentCopyByItemCopyId(params);

    return result.fold((error) => Left(error), (response) {
      try {
        final body = response.data['data'];
        final equipmentCopyModel = EquipmentCopyModel.fromMap(body);
        final equipmentCopyEntity = equipmentCopyModel.toEntity();

        getIt<Logger>().i(
          'EquipmentCopyRepoImpl: Fetched equipment copy with ID ${params.itemId} and copy number ${params.copyNum}',
        );
        return Right(equipmentCopyEntity);
      } catch (e) {
        getIt<Logger>().e(
          'EquipmentCopyRepoImpl: Failed to parse response for ID ${params.itemId} and copy number ${params.copyNum}',
          error: e,
        );
        return Left('Invalid response format');
      }
    });
  }
}
