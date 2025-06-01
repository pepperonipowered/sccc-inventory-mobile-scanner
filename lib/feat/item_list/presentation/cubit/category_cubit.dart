import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sccc_v3/feat/item_list/domain/usecase/get_all_categories_usecase.dart';
import 'package:sccc_v3/feat/item_list/presentation/cubit/category_states.dart';
import 'package:sccc_v3/service_locator.dart';

class CategoryCubit extends Cubit<CategoryStates> {
  CategoryCubit() : super(CategoryInitialState());

  Future<void> loadCategories() async {
    emit(CategoryLoadingState());
    try {
      final result = await getIt<GetAllCategoriesUsecase>().call();
      result.fold(
        (error) => emit(CategoryErrorState('Failed to load categories: $error')),
        (categories) => emit(CategoryLoadedState(categories)),
      );
    } catch (e) {
      emit(CategoryErrorState('Failed to load categories: $e'));
    }
  }
}
