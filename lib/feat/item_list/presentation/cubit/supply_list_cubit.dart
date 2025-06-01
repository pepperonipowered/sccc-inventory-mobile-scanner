import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sccc_v3/feat/item_list/data/model/supply_query_params_req.dart';
import 'package:sccc_v3/feat/item_list/domain/entity/supply_entity.dart';
import 'package:sccc_v3/feat/item_list/domain/usecase/get_all_supplies_usecase.dart';
import 'package:sccc_v3/feat/item_list/presentation/cubit/supply_list_states.dart';
import 'package:sccc_v3/service_locator.dart';

class SupplyListCubit extends Cubit<SupplyListStates> {
  SupplyListCubit() : super(SupplyLoadingState());

  Future<void> fetchSupplies({int page = 1, int perPage = 8, List<int>? categoryIds, String? search}) async {
    if (page == 1) emit(SupplyLoadingState());

    try {
      final result = await getIt<GetAllSuppliesUsecase>().call(
        param: SupplyQueryParamsReq(page: page, perPage: perPage, categoryIds: categoryIds, search: search),
      );

      result.fold(
        (error) {
          emit(SupplyErrorState('Failed to load supplies: $error'));
        },
        (paginatedResult) {
          final hasReachedMax = paginatedResult.currentPage >= paginatedResult.lastPage;

          if (state is SupplyLoadedState && page > 1) {
            final currentState = state as SupplyLoadedState;
            final updatedSupplies = List<SupplyEntity>.from(currentState.supplies)..addAll(paginatedResult.data);

            emit(
              currentState.copyWith(
                supplies: updatedSupplies,
                hasReachedMax: hasReachedMax,
                currentPage: paginatedResult.currentPage,
                lastPage: paginatedResult.lastPage,
                total: paginatedResult.total,
              ),
            );
          } else {
            // First load or filter change
            emit(
              SupplyLoadedState(
                supplies: paginatedResult.data,
                currentPage: paginatedResult.currentPage,
                lastPage: paginatedResult.lastPage,
                total: paginatedResult.total,
                hasReachedMax: hasReachedMax,
              ),
            );
          }
        },
      );
    } catch (e) {
      emit(SupplyErrorState('Failed to load supplies: $e'));
    }
  }
}
