import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sccc_v3/core/constants/api_base_url.dart';
import 'package:sccc_v3/core/network/dio_client.dart';
import 'package:sccc_v3/feat/item_list/data/model/supply_query_params_req.dart';
import 'package:sccc_v3/service_locator.dart';

abstract class SupplyService {
  Future<Either> getAllSupplies(SupplyQueryParamsReq param);
  Future<Either> getSupplyById(int id);
}

class SupplyServiceImpl implements SupplyService {
  @override
  Future<Either> getAllSupplies(SupplyQueryParamsReq param) async {
    try {
      final queryParams = param.toQueryParams();
      var response = await getIt<DioClient>().get(
        ApiUrl.officeSuppliesWithRelations,
        queryParameters: queryParams,
        options: Options(headers: {'x-api-key': ApiUrl.apiKey}),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> getSupplyById(int id) async {
    try {
      var response = await getIt<DioClient>().get(
        '${ApiUrl.officeSuppliesById}/$id',
        options: Options(headers: {'x-api-key': ApiUrl.apiKey}),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }
}
