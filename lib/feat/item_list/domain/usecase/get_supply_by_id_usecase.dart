import 'package:dartz/dartz.dart';
import 'package:sccc_v3/core/usecase/usecase.dart';
import 'package:sccc_v3/feat/item_list/domain/entity/supply_entity.dart';
import 'package:sccc_v3/feat/item_list/domain/repository/supply_repo.dart';
import 'package:sccc_v3/service_locator.dart';

class GetSupplyByIdUsecase implements UseCase<Either<dynamic,SupplyEntity>, int> {
  @override
  Future<Either<dynamic,SupplyEntity>> call({int? param}) {
    return getIt<SupplyRepo>().getSupplyById(param!);
  }
}
