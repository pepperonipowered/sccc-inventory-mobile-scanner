import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sccc_v3/core/constants/api_base_url.dart';
import 'package:sccc_v3/core/network/dio_client.dart';
import 'package:sccc_v3/service_locator.dart';

abstract class CategoryService {
  Future<Either> getAllCategories();
}

class CategoryServiceImpl implements CategoryService {
  @override
  Future<Either> getAllCategories() async {
    try {
      var response = await getIt<DioClient>().get(
        ApiUrl.category,
        options: Options(headers: {'x-api-key': ApiUrl.apiKey}),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }
}
