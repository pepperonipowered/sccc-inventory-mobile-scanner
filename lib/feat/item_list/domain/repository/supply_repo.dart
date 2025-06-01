import 'package:dartz/dartz.dart';
import 'package:sccc_v3/feat/item_list/data/model/paginated_supply_result.dart';
import 'package:sccc_v3/feat/item_list/data/model/supply_query_params_req.dart';
import 'package:sccc_v3/feat/item_list/domain/entity/supply_entity.dart';

abstract class SupplyRepo {
  Future<Either<dynamic, PaginatedSupplyResult>> getAllSupplies(SupplyQueryParamsReq param);
  Future<Either<dynamic, SupplyEntity>> getSupplyById(int id);
  
}
