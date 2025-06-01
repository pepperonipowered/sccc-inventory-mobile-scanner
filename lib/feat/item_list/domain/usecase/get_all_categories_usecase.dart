import 'package:dartz/dartz.dart';
import 'package:sccc_v3/core/usecase/usecase.dart';
import 'package:sccc_v3/feat/item_list/domain/entity/category_entity.dart';
import 'package:sccc_v3/feat/item_list/domain/repository/category_repo.dart';
import 'package:sccc_v3/service_locator.dart';

class GetAllCategoriesUsecase implements UseCase<Either<dynamic, List<CategoryEntity>>, dynamic> {
  @override
  Future<Either<dynamic, List<CategoryEntity>>> call({dynamic param}) {
    return getIt<CategoryRepo>().getAllCategories();
  }
}
