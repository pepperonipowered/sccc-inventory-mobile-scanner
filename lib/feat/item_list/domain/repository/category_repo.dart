import 'package:dartz/dartz.dart';
import 'package:sccc_v3/feat/item_list/domain/entity/category_entity.dart';

abstract class CategoryRepo {
  Future<Either<dynamic, List<CategoryEntity>>> getAllCategories();
}