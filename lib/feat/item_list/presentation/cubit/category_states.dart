import 'package:sccc_v3/feat/item_list/domain/entity/category_entity.dart';

abstract class CategoryStates {}

class CategoryInitialState extends CategoryStates {}
class CategoryLoadingState extends CategoryStates {}
class CategoryLoadedState extends CategoryStates {
  final List<CategoryEntity> categories;
  CategoryLoadedState(this.categories); 
}

class CategoryErrorState extends CategoryStates {
  final String message;

  CategoryErrorState(this.message);
}