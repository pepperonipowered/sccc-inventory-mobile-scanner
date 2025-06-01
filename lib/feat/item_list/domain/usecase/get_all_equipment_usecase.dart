import 'package:dartz/dartz.dart';
import 'package:sccc_v3/core/usecase/usecase.dart';
import 'package:sccc_v3/feat/item_list/data/model/equipment_copy_query_params_req.dart';
import 'package:sccc_v3/feat/item_list/data/model/paginated_equipment_result.dart';
import 'package:sccc_v3/feat/item_list/domain/repository/equipment_copy_repo.dart';
import 'package:sccc_v3/service_locator.dart';

class GetAllEquipmentUsecase
    implements UseCase<Either<dynamic, PaginatedEquipmentResult>, EquipmentCopyQueryParamsReq> {
  @override
  Future<Either<dynamic, PaginatedEquipmentResult>> call({EquipmentCopyQueryParamsReq? param}) {
    return getIt<EquipmentCopyRepo>().getEquipmentCopiesWithRelations(param!);
  }
}
