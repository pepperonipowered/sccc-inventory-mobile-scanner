import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:sccc_v3/feat/item_list/data/model/category_model.dart';
import 'package:sccc_v3/feat/item_list/data/source/category_service.dart';
import 'package:sccc_v3/feat/item_list/domain/entity/category_entity.dart';
import 'package:sccc_v3/feat/item_list/domain/repository/category_repo.dart';
import 'package:sccc_v3/service_locator.dart';

class CategoryRepoImpl implements CategoryRepo {
  @override
  Future<Either<dynamic, List<CategoryEntity>>> getAllCategories() async {
    Either result = await getIt<CategoryService>().getAllCategories();
    return result.fold((error) => Left(error), (data) {
      Response response = data;
      final List<CategoryModel> categoryModel =
          response.data.map<CategoryModel>((item) => CategoryModel.fromMap(item)).toList();

      getIt<Logger>().i('CategoryRepoImpl: getAllCategories: items fetched');
      return Right(categoryModel.map((e) => e.toEntity()).toList());
    });
  }
}
