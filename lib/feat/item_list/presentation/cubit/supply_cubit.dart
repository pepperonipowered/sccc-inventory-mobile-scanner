import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sccc_v3/feat/borrow_list/data/models/local_supply_model.dart';
import 'package:sccc_v3/feat/borrow_list/domain/entities/local_supply_entity.dart';
import 'package:sccc_v3/feat/borrow_list/domain/usecase/supply/create_local_supply_usecase.dart';
import 'package:sccc_v3/feat/item_list/domain/entity/supply_entity.dart';
import 'package:sccc_v3/feat/item_list/domain/usecase/get_supply_by_id_usecase.dart';
import 'package:sccc_v3/feat/item_list/presentation/cubit/supply_states.dart';
import 'package:sccc_v3/service_locator.dart';

class SupplyCubit extends Cubit<SupplyCubitStates> {
  SupplyCubit() : super(SupplyCubitLoadingState());

  // Store the current supply here
  SupplyEntity? _currentSupply;
  SupplyEntity? get currentSupply => _currentSupply;

  Future<void> getSupplyById(int id) async {
    emit(SupplyCubitLoadingState());
    try {
      final result = await getIt<GetSupplyByIdUsecase>().call(param: id);
      result.fold((error) => emit(SupplyCubitErrorState('Failed to load supply: $error')), (supply) {
        _currentSupply = supply;
        emit(SupplyCubitLoadedState(supply: supply));
      });
    } catch (e) {
      emit(SupplyCubitErrorState('Failed to load supply: $e'));
    }
  }

  Future<void> borrowSupply(LocalSupplyEntity params) async {
    emit(SupplyCubitLoadingState());
    try {
      // final model = LocalSupplyModel(params);
      await getIt<CreateLocalSupplyUsecase>().call(param: params);

      // You might want to reload or keep the same supply here
      emit(SupplyCubitLoadedState(supply: _currentSupply!));
    } catch (e) {
      emit(SupplyCubitBorrowErrorState('Failed to borrow supply: $e'));

      // Re-emit the last known good supply so the page doesn't go blank
      if (_currentSupply != null) {
        emit(SupplyCubitLoadedState(supply: _currentSupply!));
      } else {
        emit(SupplyCubitErrorState('No supply found to restore.'));
      }
    }
  }
}
