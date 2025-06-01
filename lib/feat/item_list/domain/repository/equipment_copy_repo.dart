import 'package:dartz/dartz.dart';
import 'package:sccc_v3/feat/item_list/data/model/equipment_copy_by_copy_num_and_item_id_req.dart';
import 'package:sccc_v3/feat/item_list/data/model/equipment_copy_query_params_req.dart';
import 'package:sccc_v3/feat/item_list/data/model/paginated_equipment_result.dart';
import 'package:sccc_v3/feat/item_list/domain/entity/equipment_copy_entity.dart';

abstract class EquipmentCopyRepo {
  Future<Either<dynamic, PaginatedEquipmentResult>> getEquipmentCopiesWithRelations(
    EquipmentCopyQueryParamsReq queryParams,
  );
  Future<Either<dynamic, EquipmentCopyEntity>> getEquipmentCopyByItemAndCopyId(
    EquipmentCopyByCopyNumAndItemIdReq params,
  );
}
