import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sccc_v3/core/constants/api_base_url.dart';
import 'package:sccc_v3/core/network/dio_client.dart';
import 'package:sccc_v3/feat/item_list/data/model/equipment_copy_by_copy_num_and_item_id_req.dart';
import 'package:sccc_v3/feat/item_list/data/model/equipment_copy_query_params_req.dart';
import 'package:sccc_v3/service_locator.dart';

abstract class EquipmentCopyService {
  Future<Either> getEquipmentCopiesWithRelations(EquipmentCopyQueryParamsReq params);
  Future<Either> getEquipmentCopyByItemCopyId(EquipmentCopyByCopyNumAndItemIdReq params);
}

class EquipmentCopyServiceImpl implements EquipmentCopyService {
  @override
  Future<Either> getEquipmentCopiesWithRelations(EquipmentCopyQueryParamsReq params) async {
    try {
      final queryParams = params.toQueryParams();
      var response = await getIt<DioClient>().get(
        ApiUrl.officeEquipmentWithRelations,
        queryParameters: queryParams,
        options: Options(headers: {'x-api-key': ApiUrl.apiKey}),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> getEquipmentCopyByItemCopyId(EquipmentCopyByCopyNumAndItemIdReq params) async {
    try {
      final queryParams = params.toQueryParams();
      var response = await getIt<DioClient>().get(
        //use query params instead of path params
        ApiUrl.officeEquipmentCopyByItemCopyId,
        queryParameters: queryParams,
        options: Options(headers: {'x-api-key': ApiUrl.apiKey}),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }
}
