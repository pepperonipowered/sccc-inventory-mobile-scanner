import 'package:sccc_v3/core/usecase/usecase.dart';
import 'package:sccc_v3/feat/borrow_list/domain/entities/local_equipment_copy_entity.dart';
import 'package:sccc_v3/feat/borrow_list/domain/repository/local_equipment_copy_repo.dart';
import 'package:sccc_v3/service_locator.dart';

class DeleteLocalEquipmentUsecase implements UseCase<void, LocalEquipmentCopyEntity> {
  @override
  Future<void> call({LocalEquipmentCopyEntity? param}) {
    return getIt<LocalEquipmentCopyRepo>().deleteEquipmentCopy(param!);
  }
}
