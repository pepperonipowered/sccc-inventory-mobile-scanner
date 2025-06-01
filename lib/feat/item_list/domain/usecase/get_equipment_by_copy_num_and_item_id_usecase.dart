import 'package:dartz/dartz.dart';
import 'package:sccc_v3/core/usecase/usecase.dart';
import 'package:sccc_v3/feat/item_list/data/model/equipment_copy_by_copy_num_and_item_id_req.dart';
import 'package:sccc_v3/feat/item_list/domain/entity/equipment_copy_entity.dart';
import 'package:sccc_v3/feat/item_list/domain/repository/equipment_copy_repo.dart';
import 'package:sccc_v3/service_locator.dart';

class GetEquipmentByCopyNumAndItemIdUsecase
    implements UseCase<Either<dynamic, EquipmentCopyEntity>, EquipmentCopyByCopyNumAndItemIdReq> {
  @override
  Future<Either<dynamic, EquipmentCopyEntity>> call({EquipmentCopyByCopyNumAndItemIdReq? param}) {
    return getIt<EquipmentCopyRepo>().getEquipmentCopyByItemAndCopyId(param!);
  }
}
