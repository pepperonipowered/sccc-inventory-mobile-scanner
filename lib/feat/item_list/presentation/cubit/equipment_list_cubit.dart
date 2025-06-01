import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sccc_v3/feat/item_list/data/model/equipment_copy_query_params_req.dart';
import 'package:sccc_v3/feat/item_list/domain/entity/equipment_copy_entity.dart';
import 'package:sccc_v3/feat/item_list/domain/usecase/get_all_equipment_usecase.dart';
import 'package:sccc_v3/feat/item_list/presentation/cubit/equipment_list_states.dart';
import 'package:sccc_v3/service_locator.dart';

class EquipmentListCubit extends Cubit<EquipmentListState> {
  EquipmentListCubit() : super(EquipmentListInitial());

  Future<void> fetchAllEquipment({int page = 1, int perPage = 8, List<int>? categoryIds, String? search}) async {
    if (page == 1) emit(EquipmentListLoading());

    try {
      final result = await getIt<GetAllEquipmentUsecase>().call(
        param: EquipmentCopyQueryParamsReq(page: page, perPage: perPage, categoryIds: categoryIds, search: search),
      );

      result.fold(
        (error) {
          emit(EquipmentListError('Failed to load equipment: $error'));
        },
        (paginatedResult) {
          final hasReachedMax = paginatedResult.currentPage >= paginatedResult.lastPage;

          if (state is EquipmentListLoaded && page > 1) {
            final currentState = state as EquipmentListLoaded;
            final updatedEquipment = List<EquipmentCopyEntity>.from(currentState.equipments)
              ..addAll(paginatedResult.data);

            emit(
              currentState.copyWith(
                equipments: updatedEquipment,
                hasReachedMax: hasReachedMax,
                currentPage: paginatedResult.currentPage,
                lastPage: paginatedResult.lastPage,
                total: paginatedResult.total,
              ),
            );
          } else {
            // First load or filter change
            emit(
              EquipmentListLoaded(
                equipments: paginatedResult.data,
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
      emit(EquipmentListError('Failed to load equipment: ${e.toString()}'));
    }
  }
}
