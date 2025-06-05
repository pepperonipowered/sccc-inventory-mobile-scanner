import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sccc_v3/feat/borrow_list/domain/entities/local_item_entity.dart';
import 'package:sccc_v3/feat/borrow_list/domain/usecase/create_local_item_usecase.dart';
import 'package:sccc_v3/feat/borrow_list/domain/usecase/delete_local_item_usecase.dart';
import 'package:sccc_v3/feat/borrow_list/domain/usecase/get_all_local_items_usecase.dart';
import 'package:sccc_v3/feat/borrow_list/presentation/cubit/local_item_list_states.dart';
import 'package:sccc_v3/service_locator.dart';

class LocalItemListCubit extends Cubit<LocalItemListStates> {
  LocalItemListCubit() : super(InitialLocalItemListState());

  Future<void> loadLocalItems() async {
    emit(LoadingLocalItemListState());
    try {
      final result = await getIt<GetAllLocalItemsUsecase>().call();
      emit(LoadedLocalItemListState(result));
    } catch (e) {
      emit(ErrorLocalItemListState(e.toString()));
    }
  }

  Future<void> deleteLocalItem(LocalItemEntity localItem) async {
    try {
      await getIt<DeleteLocalItemUsecase>().call(param: localItem);
      loadLocalItems();
    } catch (e) {
      emit(ErrorLocalItemListState(e.toString()));
    }
  }

  Future<void> addLocalItem(LocalItemEntity localItem) async {
    try {
      await getIt<CreateLocalItemUsecase>().call(param: localItem);
      loadLocalItems();
    } catch (e) {
      emit(ErrorLocalItemListState(e.toString()));
    }
  }
}
