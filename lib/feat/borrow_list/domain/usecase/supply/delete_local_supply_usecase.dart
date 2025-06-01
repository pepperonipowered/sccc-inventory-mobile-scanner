import 'package:sccc_v3/core/usecase/usecase.dart';
import 'package:sccc_v3/feat/borrow_list/domain/entities/local_supply_entity.dart';
import 'package:sccc_v3/feat/borrow_list/domain/repository/local_supply_repo.dart';
import 'package:sccc_v3/service_locator.dart';

class DeleteLocalSupplyUsecase implements UseCase<void, LocalSupplyEntity> {
  @override
  Future<void> call({LocalSupplyEntity? param}) {
    return getIt<LocalSupplyRepo>().addSupply(param!);
  }
}
