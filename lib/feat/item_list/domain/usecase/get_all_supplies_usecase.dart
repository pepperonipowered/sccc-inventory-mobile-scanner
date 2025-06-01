import 'package:dartz/dartz.dart';
import 'package:sccc_v3/core/usecase/usecase.dart';
import 'package:sccc_v3/feat/item_list/data/model/paginated_supply_result.dart';
import 'package:sccc_v3/feat/item_list/data/model/supply_query_params_req.dart';
import 'package:sccc_v3/feat/item_list/domain/repository/supply_repo.dart';
import 'package:sccc_v3/service_locator.dart';

class GetAllSuppliesUsecase implements UseCase<Either<dynamic,PaginatedSupplyResult>, SupplyQueryParamsReq> {
  @override
  Future<Either<dynamic, PaginatedSupplyResult>> call({SupplyQueryParamsReq? param}) {
    return getIt<SupplyRepo>().getAllSupplies(param!);
  }
}
